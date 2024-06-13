// main.go
package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"time"

	pb "confidential_communication/generated"

	"github.com/golang-jwt/jwt/v5"
	"github.com/redis/go-redis/v9"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/proto"
)

const (
	redisAddr           = "localhost:6379"
	jwtSecret           = "your-secret-key"
	tokenExpiration     = time.Hour * 24 * 30 // giorni di validata
	AuthorizationHeader = "Authorization"
)

var redisClient *redis.Client

type jwtStruct struct {
	fingerprint string
}

type server struct {
	pb.UnimplementedMessageServiceServer
}

func init() {
	redisClient = redis.NewClient(&redis.Options{
		Addr: redisAddr,
	})
}

func (s *server) ValidateSignature(ctx context.Context, req *pb.SignatureRequest) (*pb.JWTResponse, error) {
	// Here goes the signature validation logic using OpenPGP
	// For simplicity, let's assume the validation is successful and extract the fingerprint

	var fingerprint string

	if req.Protocol == pb.Enum_OPENPGP {
		fingerprint = string(req.Proof)
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
		"exp":         time.Now().Add(tokenExpiration).Unix(),
	})

	tokenString, _ := token.SignedString([]byte(jwtSecret))

	return tokenString
}

func (s *server) PutMessage(ctx context.Context, req *pb.PutMessageRequest) (*pb.Empty, error) {

	// Store message in Redis

	_, err := getTokenFromContext(ctx)

	if err != nil {
		return nil, err
	}

	fmt.Printf("putting message %s", req.RecipientId)

	if req.RecipientId == "" {
		return nil, status.Error(codes.InvalidArgument, "invalid RecipientId")
	}

	bytes, _ := proto.Marshal(req)

	err = redisClient.RPush(ctx, req.RecipientId, bytes).Err()

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

	val, err := redisClient.LRange(ctx, token.fingerprint, 0, -1).Result()
	if err != nil {
		return nil, err
	}

	messages := make([]*pb.GenericMessage, 0)

	for _, ele := range val {
		m := &pb.GenericMessage{}

		proto.Unmarshal([]byte(ele), m)

		messages = append(messages, m)
	}

	redisClient.Del(ctx, token.fingerprint)

	return &pb.GetMessagesResponse{Messages: messages}, nil
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
			// Don't forget to validate the alg is what you expect:
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, fmt.Errorf("Unexpected signing method: %v", token.Header["alg"])
			}

			// hmacSampleSecret is a []byte containing your secret, e.g. []byte("my_secret_key")
			return []byte(jwtSecret), nil
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
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}
	s := grpc.NewServer(

	//grpc.UnaryInterceptor(unaryInterceptor),
	)

	pb.RegisterMessageServiceServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
