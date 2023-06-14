///
//  Generated code. Do not modify.
//  source: message_storage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'message_storage.pb.dart' as $0;
export 'message_storage.pb.dart';

class MessageStorageClient extends $grpc.Client {
  static final _$store = $grpc.ClientMethod<$0.StoreRequest, $0.Empty>(
      '/helloworld.MessageStorage/store',
      ($0.StoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$gets = $grpc.ClientMethod<$0.GetsRequest, $0.GetsResponse>(
      '/helloworld.MessageStorage/gets',
      ($0.GetsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetsResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$0.DeleteRequest, $0.Empty>(
      '/helloworld.MessageStorage/delete',
      ($0.DeleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  MessageStorageClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> store($0.StoreRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$store, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetsResponse> gets($0.GetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$gets, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> delete($0.DeleteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }
}

abstract class MessageStorageServiceBase extends $grpc.Service {
  $core.String get $name => 'helloworld.MessageStorage';

  MessageStorageServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StoreRequest, $0.Empty>(
        'store',
        store_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StoreRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetsRequest, $0.GetsResponse>(
        'gets',
        gets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetsRequest.fromBuffer(value),
        ($0.GetsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRequest, $0.Empty>(
        'delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> store_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StoreRequest> request) async {
    return store(call, await request);
  }

  $async.Future<$0.GetsResponse> gets_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetsRequest> request) async {
    return gets(call, await request);
  }

  $async.Future<$0.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$0.DeleteRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$0.Empty> store(
      $grpc.ServiceCall call, $0.StoreRequest request);
  $async.Future<$0.GetsResponse> gets(
      $grpc.ServiceCall call, $0.GetsRequest request);
  $async.Future<$0.Empty> delete(
      $grpc.ServiceCall call, $0.DeleteRequest request);
}
