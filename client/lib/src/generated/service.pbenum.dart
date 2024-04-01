//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Enum extends $pb.ProtobufEnum {
  static const Enum OPENPGP = Enum._(0, _omitEnumNames ? '' : 'OPENPGP');

  static const $core.List<Enum> values = <Enum> [
    OPENPGP,
  ];

  static final $core.Map<$core.int, Enum> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Enum? valueOf($core.int value) => _byValue[value];

  const Enum._($core.int v, $core.String n) : super(v, n);
}

class Compression extends $pb.ProtobufEnum {
  static const Compression UNCOMPRESSED = Compression._(0, _omitEnumNames ? '' : 'UNCOMPRESSED');
  static const Compression ZIP = Compression._(1, _omitEnumNames ? '' : 'ZIP');
  static const Compression ZLIB = Compression._(2, _omitEnumNames ? '' : 'ZLIB');
  static const Compression BZIP2 = Compression._(3, _omitEnumNames ? '' : 'BZIP2');
  static const Compression PROTOCOL_MANAGED = Compression._(10, _omitEnumNames ? '' : 'PROTOCOL_MANAGED');

  static const $core.List<Compression> values = <Compression> [
    UNCOMPRESSED,
    ZIP,
    ZLIB,
    BZIP2,
    PROTOCOL_MANAGED,
  ];

  static final $core.Map<$core.int, Compression> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Compression? valueOf($core.int value) => _byValue[value];

  const Compression._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
