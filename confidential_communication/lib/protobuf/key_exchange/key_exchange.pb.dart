///
//  Generated code. Do not modify.
//  source: key_exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class InitialKeyExchange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitialKeyExchange', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'registrationId', $pb.PbFieldType.O3, protoName: 'registrationId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preKeyId', $pb.PbFieldType.O3, protoName: 'preKeyId')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preKeyPublic', $pb.PbFieldType.OY, protoName: 'preKeyPublic')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signedPreKeyId', $pb.PbFieldType.O3, protoName: 'signedPreKeyId')
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signedPreKeyPublic', $pb.PbFieldType.OY, protoName: 'signedPreKeyPublic')
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remoteIdentity', $pb.PbFieldType.OY, protoName: 'remoteIdentity')
    ..hasRequiredFields = false
  ;

  InitialKeyExchange._() : super();
  factory InitialKeyExchange({
    $core.String? name,
    $core.int? registrationId,
    $core.int? preKeyId,
    $core.List<$core.int>? preKeyPublic,
    $core.int? signedPreKeyId,
    $core.List<$core.int>? signedPreKeyPublic,
    $core.List<$core.int>? signature,
    $core.List<$core.int>? remoteIdentity,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (registrationId != null) {
      _result.registrationId = registrationId;
    }
    if (preKeyId != null) {
      _result.preKeyId = preKeyId;
    }
    if (preKeyPublic != null) {
      _result.preKeyPublic = preKeyPublic;
    }
    if (signedPreKeyId != null) {
      _result.signedPreKeyId = signedPreKeyId;
    }
    if (signedPreKeyPublic != null) {
      _result.signedPreKeyPublic = signedPreKeyPublic;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    if (remoteIdentity != null) {
      _result.remoteIdentity = remoteIdentity;
    }
    return _result;
  }
  factory InitialKeyExchange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitialKeyExchange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitialKeyExchange clone() => InitialKeyExchange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitialKeyExchange copyWith(void Function(InitialKeyExchange) updates) => super.copyWith((message) => updates(message as InitialKeyExchange)) as InitialKeyExchange; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitialKeyExchange create() => InitialKeyExchange._();
  InitialKeyExchange createEmptyInstance() => create();
  static $pb.PbList<InitialKeyExchange> createRepeated() => $pb.PbList<InitialKeyExchange>();
  @$core.pragma('dart2js:noInline')
  static InitialKeyExchange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitialKeyExchange>(create);
  static InitialKeyExchange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get registrationId => $_getIZ(1);
  @$pb.TagNumber(2)
  set registrationId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRegistrationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRegistrationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get preKeyId => $_getIZ(2);
  @$pb.TagNumber(3)
  set preKeyId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPreKeyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreKeyId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get preKeyPublic => $_getN(3);
  @$pb.TagNumber(4)
  set preKeyPublic($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPreKeyPublic() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreKeyPublic() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get signedPreKeyId => $_getIZ(4);
  @$pb.TagNumber(5)
  set signedPreKeyId($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSignedPreKeyId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSignedPreKeyId() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get signedPreKeyPublic => $_getN(5);
  @$pb.TagNumber(6)
  set signedPreKeyPublic($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSignedPreKeyPublic() => $_has(5);
  @$pb.TagNumber(6)
  void clearSignedPreKeyPublic() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get signature => $_getN(6);
  @$pb.TagNumber(7)
  set signature($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSignature() => $_has(6);
  @$pb.TagNumber(7)
  void clearSignature() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get remoteIdentity => $_getN(7);
  @$pb.TagNumber(8)
  set remoteIdentity($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRemoteIdentity() => $_has(7);
  @$pb.TagNumber(8)
  void clearRemoteIdentity() => clearField(8);
}

