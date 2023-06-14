///
//  Generated code. Do not modify.
//  source: key_exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use initialKeyExchangeDescriptor instead')
const InitialKeyExchange$json = const {
  '1': 'InitialKeyExchange',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'registrationId', '3': 2, '4': 1, '5': 5, '10': 'registrationId'},
    const {'1': 'preKeyId', '3': 3, '4': 1, '5': 5, '10': 'preKeyId'},
    const {'1': 'preKeyPublic', '3': 4, '4': 1, '5': 12, '10': 'preKeyPublic'},
    const {'1': 'signedPreKeyId', '3': 5, '4': 1, '5': 5, '10': 'signedPreKeyId'},
    const {'1': 'signedPreKeyPublic', '3': 6, '4': 1, '5': 12, '10': 'signedPreKeyPublic'},
    const {'1': 'signature', '3': 7, '4': 1, '5': 12, '10': 'signature'},
    const {'1': 'remoteIdentity', '3': 8, '4': 1, '5': 12, '10': 'remoteIdentity'},
  ],
};

/// Descriptor for `InitialKeyExchange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initialKeyExchangeDescriptor = $convert.base64Decode('ChJJbml0aWFsS2V5RXhjaGFuZ2USEgoEbmFtZRgBIAEoCVIEbmFtZRImCg5yZWdpc3RyYXRpb25JZBgCIAEoBVIOcmVnaXN0cmF0aW9uSWQSGgoIcHJlS2V5SWQYAyABKAVSCHByZUtleUlkEiIKDHByZUtleVB1YmxpYxgEIAEoDFIMcHJlS2V5UHVibGljEiYKDnNpZ25lZFByZUtleUlkGAUgASgFUg5zaWduZWRQcmVLZXlJZBIuChJzaWduZWRQcmVLZXlQdWJsaWMYBiABKAxSEnNpZ25lZFByZUtleVB1YmxpYxIcCglzaWduYXR1cmUYByABKAxSCXNpZ25hdHVyZRImCg5yZW1vdGVJZGVudGl0eRgIIAEoDFIOcmVtb3RlSWRlbnRpdHk=');
