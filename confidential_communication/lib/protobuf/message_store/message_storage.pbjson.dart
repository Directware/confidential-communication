///
//  Generated code. Do not modify.
//  source: message_storage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use storeRequestDescriptor instead')
const StoreRequest$json = const {
  '1': 'StoreRequest',
  '2': const [
    const {'1': 'destinationPublicKey', '3': 1, '4': 1, '5': 12, '10': 'destinationPublicKey'},
    const {'1': 'message', '3': 2, '4': 1, '5': 12, '10': 'message'},
  ],
};

/// Descriptor for `StoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeRequestDescriptor = $convert.base64Decode('CgxTdG9yZVJlcXVlc3QSMgoUZGVzdGluYXRpb25QdWJsaWNLZXkYASABKAxSFGRlc3RpbmF0aW9uUHVibGljS2V5EhgKB21lc3NhZ2UYAiABKAxSB21lc3NhZ2U=');
@$core.Deprecated('Use getsRequestDescriptor instead')
const GetsRequest$json = const {
  '1': 'GetsRequest',
  '2': const [
    const {'1': 'publicKey', '3': 1, '4': 1, '5': 12, '10': 'publicKey'},
  ],
};

/// Descriptor for `GetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getsRequestDescriptor = $convert.base64Decode('CgtHZXRzUmVxdWVzdBIcCglwdWJsaWNLZXkYASABKAxSCXB1YmxpY0tleQ==');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 12, '10': 'message'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEhgKB21lc3NhZ2UYASABKAxSB21lc3NhZ2U=');
@$core.Deprecated('Use deleteRequestDescriptor instead')
const DeleteRequest$json = const {
  '1': 'DeleteRequest',
  '2': const [
    const {'1': 'identityKey', '3': 1, '4': 1, '5': 12, '10': 'identityKey'},
  ],
};

/// Descriptor for `DeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRequestDescriptor = $convert.base64Decode('Cg1EZWxldGVSZXF1ZXN0EiAKC2lkZW50aXR5S2V5GAEgASgMUgtpZGVudGl0eUtleQ==');
@$core.Deprecated('Use getsResponseDescriptor instead')
const GetsResponse$json = const {
  '1': 'GetsResponse',
  '2': const [
    const {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.helloworld.Message', '10': 'messages'},
  ],
};

/// Descriptor for `GetsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getsResponseDescriptor = $convert.base64Decode('CgxHZXRzUmVzcG9uc2USLwoIbWVzc2FnZXMYASADKAsyEy5oZWxsb3dvcmxkLk1lc3NhZ2VSCG1lc3NhZ2Vz');
@$core.Deprecated('Use requestIdDescriptor instead')
const RequestId$json = const {
  '1': 'RequestId',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `RequestId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestIdDescriptor = $convert.base64Decode('CglSZXF1ZXN0SWQSFAoFdmFsdWUYASABKAxSBXZhbHVl');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
