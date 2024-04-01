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
)

const (
	redisAddr           = "localhost:6379"
	jwtSecret           = "your-secret-key"
	tokenExpiration     = time.Hour * 24 * 30 // giorni di validata
	AuthorizationHeader = "Authorization"
)

var redisClient *redis.Client

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
		fingerprint = "example-fingerprint"
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

	token, err := getTokenFromContext(ctx)

	if err != nil {
		return nil, err
	}

	fmt.Println(token)

	if req.RecipientId == "" {
		return nil, status.Error(codes.InvalidArgument, "invalid RecipientId")
	}

	err = redisClient.Set(ctx, req.RecipientId, req.Message, 0).Err()

	if err != nil {
		return nil, err
	}

	return &pb.Empty{}, nil
}

func (s *server) GetMessage(ctx context.Context, req *pb.GetMessagesRequest) (*pb.GetMessagesResponse, error) {
	// Retrieve message from Redis

	val, err := redisClient.Get(ctx, "").Result()
	if err != nil {
		return nil, err
	}

	return &pb.GetMessagesResponse{Messages: []*pb.GenericMessage{{Payload: []byte(val)}}}, nil
}

func getTokenFromContext(ctx context.Context) (string, error) {

	md, ok := metadata.FromIncomingContext(ctx)
	var values []string
	var token string

	if ok {
		values = md.Get(AuthorizationHeader)

	} else {
		return "", fmt.Errorf("authorization token is not present")
	}

	if len(values) > 0 {
		token = values[0]
	} else {
		return "", fmt.Errorf("authorization token is not present")
	}

	return token, nil

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
