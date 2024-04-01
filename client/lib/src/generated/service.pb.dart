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

import 'service.pbenum.dart';

export 'service.pbenum.dart';

class SignatureRequest extends $pb.GeneratedMessage {
  factory SignatureRequest({
    Enum? protocol,
    $core.int? version,
    $core.List<$core.int>? proof,
  }) {
    final $result = create();
    if (protocol != null) {
      $result.protocol = protocol;
    }
    if (version != null) {
      $result.version = version;
    }
    if (proof != null) {
      $result.proof = proof;
    }
    return $result;
  }
  SignatureRequest._() : super();
  factory SignatureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignatureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignatureRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..e<Enum>(1, _omitFieldNames ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: Enum.OPENPGP, valueOf: Enum.valueOf, enumValues: Enum.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'proof', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignatureRequest clone() => SignatureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignatureRequest copyWith(void Function(SignatureRequest) updates) => super.copyWith((message) => updates(message as SignatureRequest)) as SignatureRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignatureRequest create() => SignatureRequest._();
  SignatureRequest createEmptyInstance() => create();
  static $pb.PbList<SignatureRequest> createRepeated() => $pb.PbList<SignatureRequest>();
  @$core.pragma('dart2js:noInline')
  static SignatureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignatureRequest>(create);
  static SignatureRequest? _defaultInstance;

  /// Your OpenPGP signature or any necessary data for validation
  /// Add fields as needed
  @$pb.TagNumber(1)
  Enum get protocol => $_getN(0);
  @$pb.TagNumber(1)
  set protocol(Enum v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProtocol() => $_has(0);
  @$pb.TagNumber(1)
  void clearProtocol() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get proof => $_getN(2);
  @$pb.TagNumber(3)
  set proof($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProof() => $_has(2);
  @$pb.TagNumber(3)
  void clearProof() => clearField(3);
}

class InitialExchange extends $pb.GeneratedMessage {
  factory InitialExchange({
    $core.String? name,
    $core.String? id,
    $core.List<$core.int>? publicKey,
    Enum? protocol,
    $core.String? serverURL,
    $core.int? version,
    $core.bool? isPayloadEncrypted,
    $core.List<$core.int>? challenge,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (id != null) {
      $result.id = id;
    }
    if (publicKey != null) {
      $result.publicKey = publicKey;
    }
    if (protocol != null) {
      $result.protocol = protocol;
    }
    if (serverURL != null) {
      $result.serverURL = serverURL;
    }
    if (version != null) {
      $result.version = version;
    }
    if (isPayloadEncrypted != null) {
      $result.isPayloadEncrypted = isPayloadEncrypted;
    }
    if (challenge != null) {
      $result.challenge = challenge;
    }
    return $result;
  }
  InitialExchange._() : super();
  factory InitialExchange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitialExchange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InitialExchange', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY, protoName: 'publicKey')
    ..e<Enum>(4, _omitFieldNames ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: Enum.OPENPGP, valueOf: Enum.valueOf, enumValues: Enum.values)
    ..aOS(5, _omitFieldNames ? '' : 'serverURL', protoName: 'serverURL')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU3)
    ..aOB(7, _omitFieldNames ? '' : 'isPayloadEncrypted', protoName: 'isPayloadEncrypted')
    ..a<$core.List<$core.int>>(8, _omitFieldNames ? '' : 'challenge', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitialExchange clone() => InitialExchange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitialExchange copyWith(void Function(InitialExchange) updates) => super.copyWith((message) => updates(message as InitialExchange)) as InitialExchange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitialExchange create() => InitialExchange._();
  InitialExchange createEmptyInstance() => create();
  static $pb.PbList<InitialExchange> createRepeated() => $pb.PbList<InitialExchange>();
  @$core.pragma('dart2js:noInline')
  static InitialExchange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitialExchange>(create);
  static InitialExchange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get publicKey => $_getN(2);
  @$pb.TagNumber(3)
  set publicKey($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicKey() => clearField(3);

  @$pb.TagNumber(4)
  Enum get protocol => $_getN(3);
  @$pb.TagNumber(4)
  set protocol(Enum v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasProtocol() => $_has(3);
  @$pb.TagNumber(4)
  void clearProtocol() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get serverURL => $_getSZ(4);
  @$pb.TagNumber(5)
  set serverURL($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasServerURL() => $_has(4);
  @$pb.TagNumber(5)
  void clearServerURL() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get version => $_getIZ(5);
  @$pb.TagNumber(6)
  set version($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isPayloadEncrypted => $_getBF(6);
  @$pb.TagNumber(7)
  set isPayloadEncrypted($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsPayloadEncrypted() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsPayloadEncrypted() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get challenge => $_getN(7);
  @$pb.TagNumber(8)
  set challenge($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasChallenge() => $_has(7);
  @$pb.TagNumber(8)
  void clearChallenge() => clearField(8);
}

enum GenericMessage_TypeOfMessage {
  initialExchange, 
  notSet
}

class GenericMessage extends $pb.GeneratedMessage {
  factory GenericMessage({
    $core.List<$core.int>? payload,
    Enum? compression,
    $core.int? type,
    InitialExchange? initialExchange,
  }) {
    final $result = create();
    if (payload != null) {
      $result.payload = payload;
    }
    if (compression != null) {
      $result.compression = compression;
    }
    if (type != null) {
      $result.type = type;
    }
    if (initialExchange != null) {
      $result.initialExchange = initialExchange;
    }
    return $result;
  }
  GenericMessage._() : super();
  factory GenericMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenericMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, GenericMessage_TypeOfMessage> _GenericMessage_TypeOfMessageByTag = {
    4 : GenericMessage_TypeOfMessage.initialExchange,
    0 : GenericMessage_TypeOfMessage.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenericMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..oo(0, [4])
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..e<Enum>(2, _omitFieldNames ? '' : 'Compression', $pb.PbFieldType.OE, protoName: 'Compression', defaultOrMaker: Enum.OPENPGP, valueOf: Enum.valueOf, enumValues: Enum.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OU3)
    ..aOM<InitialExchange>(4, _omitFieldNames ? '' : 'initialExchange', protoName: 'initialExchange', subBuilder: InitialExchange.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenericMessage clone() => GenericMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenericMessage copyWith(void Function(GenericMessage) updates) => super.copyWith((message) => updates(message as GenericMessage)) as GenericMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenericMessage create() => GenericMessage._();
  GenericMessage createEmptyInstance() => create();
  static $pb.PbList<GenericMessage> createRepeated() => $pb.PbList<GenericMessage>();
  @$core.pragma('dart2js:noInline')
  static GenericMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenericMessage>(create);
  static GenericMessage? _defaultInstance;

  GenericMessage_TypeOfMessage whichTypeOfMessage() => _GenericMessage_TypeOfMessageByTag[$_whichOneof(0)]!;
  void clearTypeOfMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => clearField(1);

  @$pb.TagNumber(2)
  Enum get compression => $_getN(1);
  @$pb.TagNumber(2)
  set compression(Enum v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCompression() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompression() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get type => $_getIZ(2);
  @$pb.TagNumber(3)
  set type($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  InitialExchange get initialExchange => $_getN(3);
  @$pb.TagNumber(4)
  set initialExchange(InitialExchange v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasInitialExchange() => $_has(3);
  @$pb.TagNumber(4)
  void clearInitialExchange() => clearField(4);
  @$pb.TagNumber(4)
  InitialExchange ensureInitialExchange() => $_ensure(3);
}

class JWTResponse extends $pb.GeneratedMessage {
  factory JWTResponse({
    $core.String? token,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  JWTResponse._() : super();
  factory JWTResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JWTResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JWTResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JWTResponse clone() => JWTResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JWTResponse copyWith(void Function(JWTResponse) updates) => super.copyWith((message) => updates(message as JWTResponse)) as JWTResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JWTResponse create() => JWTResponse._();
  JWTResponse createEmptyInstance() => create();
  static $pb.PbList<JWTResponse> createRepeated() => $pb.PbList<JWTResponse>();
  @$core.pragma('dart2js:noInline')
  static JWTResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JWTResponse>(create);
  static JWTResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
}

class PutMessageRequest extends $pb.GeneratedMessage {
  factory PutMessageRequest({
    $core.String? recipientId,
    GenericMessage? message,
  }) {
    final $result = create();
    if (recipientId != null) {
      $result.recipientId = recipientId;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  PutMessageRequest._() : super();
  factory PutMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PutMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PutMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipientId', protoName: 'recipientId')
    ..aOM<GenericMessage>(2, _omitFieldNames ? '' : 'message', subBuilder: GenericMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PutMessageRequest clone() => PutMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PutMessageRequest copyWith(void Function(PutMessageRequest) updates) => super.copyWith((message) => updates(message as PutMessageRequest)) as PutMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PutMessageRequest create() => PutMessageRequest._();
  PutMessageRequest createEmptyInstance() => create();
  static $pb.PbList<PutMessageRequest> createRepeated() => $pb.PbList<PutMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static PutMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PutMessageRequest>(create);
  static PutMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => clearField(1);

  @$pb.TagNumber(2)
  GenericMessage get message => $_getN(1);
  @$pb.TagNumber(2)
  set message(GenericMessage v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
  @$pb.TagNumber(2)
  GenericMessage ensureMessage() => $_ensure(1);
}

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class GetMessagesRequest extends $pb.GeneratedMessage {
  factory GetMessagesRequest() => create();
  GetMessagesRequest._() : super();
  factory GetMessagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMessagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMessagesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMessagesRequest clone() => GetMessagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMessagesRequest copyWith(void Function(GetMessagesRequest) updates) => super.copyWith((message) => updates(message as GetMessagesRequest)) as GetMessagesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest create() => GetMessagesRequest._();
  GetMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMessagesRequest> createRepeated() => $pb.PbList<GetMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesRequest>(create);
  static GetMessagesRequest? _defaultInstance;
}

class GetMessagesResponse extends $pb.GeneratedMessage {
  factory GetMessagesResponse({
    $core.Iterable<GenericMessage>? messages,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    return $result;
  }
  GetMessagesResponse._() : super();
  factory GetMessagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMessagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMessagesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'definition'), createEmptyInstance: create)
    ..pc<GenericMessage>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: GenericMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMessagesResponse clone() => GetMessagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMessagesResponse copyWith(void Function(GetMessagesResponse) updates) => super.copyWith((message) => updates(message as GetMessagesResponse)) as GetMessagesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse create() => GetMessagesResponse._();
  GetMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMessagesResponse> createRepeated() => $pb.PbList<GetMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesResponse>(create);
  static GetMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GenericMessage> get messages => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
