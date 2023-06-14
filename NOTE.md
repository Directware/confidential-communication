compile protobuf for dart

```sheel
protoc --dart_out=grpc:confidential-communication/lib/protobuf/message_store -Iprotos protos/message_storage.proto

```