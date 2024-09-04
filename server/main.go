// main.go
package main

import (
	"bytes"
	"context"
	"fmt"
	"net"
	"time"

	pb "confidential_communication/generated"

	"github.com/ProtonMail/go-crypto/openpgp"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/proto"

	"github.com/rs/zerolog/log"
)

var redisClient *redis.Client

type jwtStruct struct {
	fingerprint string
}

type server struct {
	pb.UnimplementedMessageServiceServer
}

func initRedis() {

	redisClient = redis.NewClient(&redis.Options{
		Addr: appConfig.Redis.Address,
	})

	err := redisClient.Ping(context.Background()).Err()

	if err != nil {
		log.Error().Err(err).Msgf("Falied to ping redis to address %s", appConfig.Redis.Address)
	}

	getMessageScript.Load(context.Background(), redisClient)
	deleteOldMessageScript.Load(context.Background(), redisClient)

}

func (s *server) ValidateSignature(ctx context.Context, req *pb.SignatureRequest) (*pb.JWTResponse, error) {
	// Here goes the signature validation logic using OpenPGP
	// For simplicity, let's assume the validation is successful and extract the fingerprint

	var fingerprint string

	if req.Protocol == pb.Enum_OPENPGP {

		keyRing, err := openpgp.ReadKeyRing(bytes.NewReader(req.PublicKey))

		if err != nil {
			return nil, err
		}

		reqDetailBytes, _ := proto.Marshal(req.Detail)

		signer, err := openpgp.CheckDetachedSignature(keyRing, bytes.NewReader(reqDetailBytes), bytes.NewReader(req.Proof), nil)

		if err != nil {
			return nil, err
		}

		if fmt.Sprintf("%x", signer.PrimaryKey.Fingerprint) != req.Detail.FingerPrint {
			return nil, fmt.Errorf("fingerprint from the signature do not match")
		}

		fingerprint = req.Detail.FingerPrint

	} else {
		err := status.Error(codes.Unimplemented, "this Protocol is unimplemented")
		return nil, err
	}

	tokenString := generateJWT(fingerprint)

	return &pb.JWTResponse{Token: tokenString}, nil
}

func generateJWT(fingerprint string) string {
	// Create JWT token with HMAC-SHA256 signing

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"fingerprint": fingerprint,
		"exp":         time.Now().Add(appConfig.Token.Expiration).Unix(),
	})

	tokenString, _ := token.SignedString([]byte(appConfig.Token.JWTSecret))

	return tokenString
}

func (s *server) PutMessage(ctx context.Context, req *pb.PutMessageRequest) (*pb.Empty, error) {

	_, err := getTokenFromContext(ctx)

	if err != nil {
		return nil, err
	}

	fmt.Printf("putting message %s\n", req.RecipientId)

	if req.RecipientId == "" {
		return nil, status.Error(codes.InvalidArgument, "invalid RecipientId")
	}

	bytes, _ := proto.Marshal(req)

	err = redisClient.XAdd(ctx, &redis.XAddArgs{Stream: req.RecipientId, Values: map[string]interface{}{"type": "message", "body": bytes}}).Err()

	if err != nil {
		return nil, err
	}

	return &pb.Empty{}, nil
}

func (s *server) PutGroupMessage(ctx context.Context, req *pb.PutGroupMessageRequest) (*pb.Empty, error) {

	_, err := getTokenFromContext(ctx)

	if err != nil {
		return nil, err
	}

	bytes, _ := proto.Marshal(req)
	uniqueId, _ := uuid.NewV7()

	uniqueIdStr := uniqueId.String()

	fmt.Printf("putting group message with id %s\n", uniqueIdStr)

	redisClient.HSet(ctx, uniqueIdStr, map[string]interface{}{"remain": len(req.RecipientsId), "message": bytes})

	for _, recipient := range req.RecipientsId {
		err = redisClient.XAdd(ctx, &redis.XAddArgs{Stream: recipient, Values: map[string]interface{}{"type": "reference", "r": uniqueIdStr}}).Err()
	}

	if err != nil {
		return nil, err
	}

	return &pb.Empty{}, nil
}

func (s *server) GetMessages(ctx context.Context, req *pb.GetMessagesRequest) (*pb.GetMessagesResponse, error) {
	// Retrieve message from Redis

	token, err := getTokenFromContext(ctx)

	fmt.Println(token.fingerprint)

	if err != nil {
		return nil, err
	}

	result, err := getMessageScript.Run(ctx, redisClient, []string{token.fingerprint}, req.LastId, appConfig.Limit.MaxMessageInGetRequest).Slice()
	go func() {
		err = deleteOldMessageScript.Run(context.Background(), redisClient, []string{token.fingerprint}, req.LastId).Err()

		if err != nil {
			fmt.Println(err)
		}
	}()

	if err != nil {
		log.Error().Err(err).Msgf("falied to execute script to get Message")
		return nil, fmt.Errorf("Unable to get message")
	}

	if err != nil {
		return nil, err
	}

	messages := make([]*pb.GenericMessage, 0)
	var lastID string

	if len(result) == 2 {
		elements := result[0].([]interface{})
		lastID = result[1].(string)

		for _, ele := range elements {
			m := &pb.GenericMessage{}
			bodyMessage := []byte(ele.(string))
			proto.Unmarshal(bodyMessage, m)
			messages = append(messages, m)

		}

		fmt.Println("Last ID:", lastID)
	} else {
		fmt.Println("empty result:", result)
		return &pb.GetMessagesResponse{Messages: messages, LastId: req.LastId}, nil
	}

	return &pb.GetMessagesResponse{Messages: messages, LastId: lastID}, nil
}

func getTokenFromContext(ctx context.Context) (*jwtStruct, error) {

	md, ok := metadata.FromIncomingContext(ctx)
	var values []string
	var token string

	if ok {
		values = md.Get(AuthorizationHeader)

	} else {
		return nil, fmt.Errorf("authorization token is not present")
	}

	if len(values) > 0 {
		token = values[0]

		token, err := jwt.Parse(token, func(token *jwt.Token) (interface{}, error) {
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, fmt.Errorf("Unexpected signing method: %v", token.Header["alg"])
			}

			return []byte(appConfig.Token.JWTSecret), nil
		})

		if err != nil {
			return nil, err
		}

		if claims, ok := token.Claims.(jwt.MapClaims); ok {

			fingerprint, ok := claims["fingerprint"].(string)

			if !ok {
				return nil, fmt.Errorf("invalid claim present")
			}

			return &jwtStruct{fingerprint: fingerprint}, nil
		} else {
			return nil, fmt.Errorf("invalid claim present")
		}

	} else {
		return nil, fmt.Errorf("authorization token is not present")
	}

}
func main() {

	parseConfig()
	initRedis()

	lis, err := net.Listen("tcp", appConfig.Server.Address)
	if err != nil {
		log.Fatal().Err(err).Msg("Failed to listen")
	}
	s := grpc.NewServer(

	//grpc.UnaryInterceptor(unaryInterceptor),
	)

	pb.RegisterMessageServiceServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatal().Err(err).Msg("Failed to serve")

	}
}
