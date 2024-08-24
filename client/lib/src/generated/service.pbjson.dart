//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use enumDescriptor instead')
const Enum$json = {
  '1': 'Enum',
  '2': [
    {'1': 'OPENPGP', '2': 0},
  ],
};

/// Descriptor for `Enum`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List enumDescriptor = $convert.base64Decode(
    'CgRFbnVtEgsKB09QRU5QR1AQAA==');

@$core.Deprecated('Use compressionDescriptor instead')
const Compression$json = {
  '1': 'Compression',
  '2': [
    {'1': 'UNCOMPRESSED', '2': 0},
    {'1': 'ZIP', '2': 1},
    {'1': 'ZLIB', '2': 2},
    {'1': 'BZIP2', '2': 3},
    {'1': 'PROTOCOL_MANAGED', '2': 10},
  ],
};

/// Descriptor for `Compression`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List compressionDescriptor = $convert.base64Decode(
    'CgtDb21wcmVzc2lvbhIQCgxVTkNPTVBSRVNTRUQQABIHCgNaSVAQARIICgRaTElCEAISCQoFQl'
    'pJUDIQAxIUChBQUk9UT0NPTF9NQU5BR0VEEAo=');

@$core.Deprecated('Use signatureRequestDetailDescriptor instead')
const SignatureRequestDetail$json = {
  '1': 'SignatureRequestDetail',
  '2': [
    {'1': 'requestId', '3': 4, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'requestTime', '3': 5, '4': 1, '5': 3, '10': 'requestTime'},
    {'1': 'fingerPrint', '3': 6, '4': 1, '5': 9, '10': 'fingerPrint'},
  ],
};

/// Descriptor for `SignatureRequestDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signatureRequestDetailDescriptor = $convert.base64Decode(
    'ChZTaWduYXR1cmVSZXF1ZXN0RGV0YWlsEhwKCXJlcXVlc3RJZBgEIAEoCVIJcmVxdWVzdElkEi'
    'AKC3JlcXVlc3RUaW1lGAUgASgDUgtyZXF1ZXN0VGltZRIgCgtmaW5nZXJQcmludBgGIAEoCVIL'
    'ZmluZ2VyUHJpbnQ=');

@$core.Deprecated('Use signatureRequestDescriptor instead')
const SignatureRequest$json = {
  '1': 'SignatureRequest',
  '2': [
    {'1': 'protocol', '3': 1, '4': 1, '5': 14, '6': '.definition.Enum', '10': 'protocol'},
    {'1': 'version', '3': 2, '4': 1, '5': 13, '10': 'version'},
    {'1': 'proof', '3': 3, '4': 1, '5': 12, '10': 'proof'},
    {'1': 'detail', '3': 4, '4': 1, '5': 11, '6': '.definition.SignatureRequestDetail', '10': 'detail'},
    {'1': 'publicKey', '3': 5, '4': 1, '5': 12, '10': 'publicKey'},
  ],
};

/// Descriptor for `SignatureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signatureRequestDescriptor = $convert.base64Decode(
    'ChBTaWduYXR1cmVSZXF1ZXN0EiwKCHByb3RvY29sGAEgASgOMhAuZGVmaW5pdGlvbi5FbnVtUg'
    'hwcm90b2NvbBIYCgd2ZXJzaW9uGAIgASgNUgd2ZXJzaW9uEhQKBXByb29mGAMgASgMUgVwcm9v'
    'ZhI6CgZkZXRhaWwYBCABKAsyIi5kZWZpbml0aW9uLlNpZ25hdHVyZVJlcXVlc3REZXRhaWxSBm'
    'RldGFpbBIcCglwdWJsaWNLZXkYBSABKAxSCXB1YmxpY0tleQ==');

@$core.Deprecated('Use initialExchangeDescriptor instead')
const InitialExchange$json = {
  '1': 'InitialExchange',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {'1': 'publicKey', '3': 3, '4': 1, '5': 12, '10': 'publicKey'},
    {'1': 'protocol', '3': 4, '4': 1, '5': 14, '6': '.definition.Enum', '10': 'protocol'},
    {'1': 'serverURL', '3': 5, '4': 1, '5': 9, '10': 'serverURL'},
    {'1': 'version', '3': 6, '4': 1, '5': 13, '10': 'version'},
    {'1': 'isPayloadEncrypted', '3': 7, '4': 1, '5': 8, '10': 'isPayloadEncrypted'},
    {'1': 'challenge', '3': 8, '4': 1, '5': 12, '10': 'challenge'},
  ],
};

/// Descriptor for `InitialExchange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initialExchangeDescriptor = $convert.base64Decode(
    'Cg9Jbml0aWFsRXhjaGFuZ2USEgoEbmFtZRgBIAEoCVIEbmFtZRIOCgJpZBgCIAEoCVICaWQSHA'
    'oJcHVibGljS2V5GAMgASgMUglwdWJsaWNLZXkSLAoIcHJvdG9jb2wYBCABKA4yEC5kZWZpbml0'
    'aW9uLkVudW1SCHByb3RvY29sEhwKCXNlcnZlclVSTBgFIAEoCVIJc2VydmVyVVJMEhgKB3Zlcn'
    'Npb24YBiABKA1SB3ZlcnNpb24SLgoSaXNQYXlsb2FkRW5jcnlwdGVkGAcgASgIUhJpc1BheWxv'
    'YWRFbmNyeXB0ZWQSHAoJY2hhbGxlbmdlGAggASgMUgljaGFsbGVuZ2U=');

@$core.Deprecated('Use genericMessageDescriptor instead')
const GenericMessage$json = {
  '1': 'GenericMessage',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'Compression', '3': 2, '4': 1, '5': 14, '6': '.definition.Enum', '10': 'Compression'},
    {'1': 'type', '3': 3, '4': 1, '5': 13, '10': 'type'},
    {'1': 'initialExchange', '3': 4, '4': 1, '5': 11, '6': '.definition.InitialExchange', '9': 0, '10': 'initialExchange'},
  ],
  '8': [
    {'1': 'typeOfMessage'},
  ],
};

/// Descriptor for `GenericMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List genericMessageDescriptor = $convert.base64Decode(
    'Cg5HZW5lcmljTWVzc2FnZRIYCgdwYXlsb2FkGAEgASgMUgdwYXlsb2FkEjIKC0NvbXByZXNzaW'
    '9uGAIgASgOMhAuZGVmaW5pdGlvbi5FbnVtUgtDb21wcmVzc2lvbhISCgR0eXBlGAMgASgNUgR0'
    'eXBlEkcKD2luaXRpYWxFeGNoYW5nZRgEIAEoCzIbLmRlZmluaXRpb24uSW5pdGlhbEV4Y2hhbm'
    'dlSABSD2luaXRpYWxFeGNoYW5nZUIPCg10eXBlT2ZNZXNzYWdl');

@$core.Deprecated('Use jWTResponseDescriptor instead')
const JWTResponse$json = {
  '1': 'JWTResponse',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `JWTResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jWTResponseDescriptor = $convert.base64Decode(
    'CgtKV1RSZXNwb25zZRIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use putMessageRequestDescriptor instead')
const PutMessageRequest$json = {
  '1': 'PutMessageRequest',
  '2': [
    {'1': 'recipientId', '3': 1, '4': 1, '5': 9, '10': 'recipientId'},
    {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.definition.GenericMessage', '10': 'message'},
  ],
};

/// Descriptor for `PutMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putMessageRequestDescriptor = $convert.base64Decode(
    'ChFQdXRNZXNzYWdlUmVxdWVzdBIgCgtyZWNpcGllbnRJZBgBIAEoCVILcmVjaXBpZW50SWQSNA'
    'oHbWVzc2FnZRgCIAEoCzIaLmRlZmluaXRpb24uR2VuZXJpY01lc3NhZ2VSB21lc3NhZ2U=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use getMessagesRequestDescriptor instead')
const GetMessagesRequest$json = {
  '1': 'GetMessagesRequest',
  '2': [
    {'1': 'lastId', '3': 1, '4': 1, '5': 9, '10': 'lastId'},
  ],
};

/// Descriptor for `GetMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZXNzYWdlc1JlcXVlc3QSFgoGbGFzdElkGAEgASgJUgZsYXN0SWQ=');

@$core.Deprecated('Use getMessagesResponseDescriptor instead')
const GetMessagesResponse$json = {
  '1': 'GetMessagesResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.definition.GenericMessage', '10': 'messages'},
    {'1': 'lastId', '3': 2, '4': 1, '5': 9, '10': 'lastId'},
  ],
};

/// Descriptor for `GetMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZXNzYWdlc1Jlc3BvbnNlEjYKCG1lc3NhZ2VzGAEgAygLMhouZGVmaW5pdGlvbi5HZW'
    '5lcmljTWVzc2FnZVIIbWVzc2FnZXMSFgoGbGFzdElkGAIgASgJUgZsYXN0SWQ=');

@$core.Deprecated('Use putGroupMessageRequestDescriptor instead')
const PutGroupMessageRequest$json = {
  '1': 'PutGroupMessageRequest',
  '2': [
    {'1': 'recipientsId', '3': 1, '4': 3, '5': 9, '10': 'recipientsId'},
    {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.definition.GenericMessage', '10': 'message'},
  ],
};

/// Descriptor for `PutGroupMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putGroupMessageRequestDescriptor = $convert.base64Decode(
    'ChZQdXRHcm91cE1lc3NhZ2VSZXF1ZXN0EiIKDHJlY2lwaWVudHNJZBgBIAMoCVIMcmVjaXBpZW'
    '50c0lkEjQKB21lc3NhZ2UYAiABKAsyGi5kZWZpbml0aW9uLkdlbmVyaWNNZXNzYWdlUgdtZXNz'
    'YWdl');

