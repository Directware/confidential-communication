//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $0;

export 'service.pb.dart';

@$pb.GrpcServiceName('definition.MessageService')
class MessageServiceClient extends $grpc.Client {
  static final _$validateSignature = $grpc.ClientMethod<$0.SignatureRequest, $0.JWTResponse>(
      '/definition.MessageService/ValidateSignature',
      ($0.SignatureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.JWTResponse.fromBuffer(value));
  static final _$putMessage = $grpc.ClientMethod<$0.PutMessageRequest, $0.Empty>(
      '/definition.MessageService/PutMessage',
      ($0.PutMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getMessages = $grpc.ClientMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
      '/definition.MessageService/GetMessages',
      ($0.GetMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMessagesResponse.fromBuffer(value));

  MessageServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.JWTResponse> validateSignature($0.SignatureRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateSignature, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> putMessage($0.PutMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$putMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMessagesResponse> getMessages($0.GetMessagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMessages, request, options: options);
  }
}

@$pb.GrpcServiceName('definition.MessageService')
abstract class MessageServiceBase extends $grpc.Service {
  $core.String get $name => 'definition.MessageService';

  MessageServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignatureRequest, $0.JWTResponse>(
        'ValidateSignature',
        validateSignature_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignatureRequest.fromBuffer(value),
        ($0.JWTResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PutMessageRequest, $0.Empty>(
        'PutMessage',
        putMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PutMessageRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMessagesRequest, $0.GetMessagesResponse>(
        'GetMessages',
        getMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMessagesRequest.fromBuffer(value),
        ($0.GetMessagesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.JWTResponse> validateSignature_Pre($grpc.ServiceCall call, $async.Future<$0.SignatureRequest> request) async {
    return validateSignature(call, await request);
  }

  $async.Future<$0.Empty> putMessage_Pre($grpc.ServiceCall call, $async.Future<$0.PutMessageRequest> request) async {
    return putMessage(call, await request);
  }

  $async.Future<$0.GetMessagesResponse> getMessages_Pre($grpc.ServiceCall call, $async.Future<$0.GetMessagesRequest> request) async {
    return getMessages(call, await request);
  }

  $async.Future<$0.JWTResponse> validateSignature($grpc.ServiceCall call, $0.SignatureRequest request);
  $async.Future<$0.Empty> putMessage($grpc.ServiceCall call, $0.PutMessageRequest request);
  $async.Future<$0.GetMessagesResponse> getMessages($grpc.ServiceCall call, $0.GetMessagesRequest request);
}
