import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:fixnum/fixnum.dart';
import 'package:confidential_communication/src/const.dart';
import 'package:confidential_communication/src/generated/service.pb.dart';
import 'package:confidential_communication/src/generated/service.pbgrpc.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:dart_pg/src/packet/packet_list.dart';
import 'package:grpc/grpc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:uuid/uuid.dart';

class ClientNotConnected implements Exception {}

class VerificationFailed implements Exception {}

class UnknowSender implements Exception {}

extension RandomExtensions on Random {
  int get nextByte => nextInt(256);

  Uint8List nextBytes(int length) {
    final result = Uint8List(length);
    for (var i = 0; i < length; i++) {
      result[i] = nextByte;
    }
    return result;
  }
}

class AuthInterceptor implements ClientInterceptor {
  FutureOr<void> _injectToken(Map<String, String> metadata, String uri) async {
    if (!store.isTokenValid()) {
      await getToken();
    }
    final token = store.getToken();
    if (token != null) {
      metadata[authorizationHeader] = token;
    }
  }

  final Store store;
  final Future<JWTResponse> Function() getToken;
  AuthInterceptor({required this.store, required this.getToken});

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    if (requests is! Stream<SignatureRequest>) {
      final modifiedOptions = options.mergedWith(
        CallOptions(
          providers: [
            _injectToken,
          ],
        ),
      );
      return invoker(method, requests, modifiedOptions);
    }

    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    if (request is! SignatureRequest) {
      final modifiedOptions = options.mergedWith(
        CallOptions(
          providers: [
            _injectToken,
          ],
        ),
      );
      return invoker(method, request, modifiedOptions);
    }

    return invoker(method, request, options);
  }
}

class ConfidentialCommunication {
  static const int version = 1;
  Store store;
  AddressBook addressBook;
  String passphrase;
  String? address;
  int? port;
  Enum protocol;
  late CryptographicProtocol cryptographicProtocol;

  bool Function(InitialExchange)? shouldAddContact;

  MessageServiceClient? client;

  ConfidentialCommunication(
      this.store, this.addressBook, String this.passphrase,
      {String? this.address, int? this.port, this.protocol = Enum.OPENPGP}) {
    if (address != null) {
      final channel = ClientChannel(
        address!,
        port: port ?? 443,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      client = MessageServiceClient(
        channel,
        interceptors: [AuthInterceptor(store: store, getToken: getToken)],
      );
    }

    if (protocol == Enum.OPENPGP) {
      cryptographicProtocol =
          OpenPGPProtocol(store.getPrivateKey(), addressBook);
    }
  }

  Future<void> init() async {
    cryptographicProtocol.decryptPrivateKey(passphrase);
  }
  Future<GenericMessage> initialExchange(String name) async {
    var secureRandom = Random.secure();

    final challenge = secureRandom.nextBytes(16);

    final initialExchange = InitialExchange(
        name: name,
        id: cryptographicProtocol.getMyFingerprint(),
        publicKey: cryptographicProtocol.getMyPublicKey(),
        protocol: protocol,
        version: version,
        isPayloadEncrypted: false,
        serverURL: "$address:$port",
        challenge: challenge);

    final genericMessage = GenericMessage(initialExchange: initialExchange);

    return genericMessage;
  }

  void processInitialExchange(GenericMessage m, String name) async {
    if (m.whichTypeOfMessage() !=
        GenericMessage_TypeOfMessage.initialExchange) {
      throw Exception("invalid message");
    }

    final contact = Contact(Uint8List.fromList(m.initialExchange.publicKey),
        m.initialExchange.name);
    addressBook.addContact(m.initialExchange.id, contact);

    final messageToSend = await initialExchange(name);

    final result = await client!.putMessage(
        PutMessageRequest(
            recipientId: m.initialExchange.id, message: messageToSend),
       );
  }

  Stream<(Contact, GenericMessage)> receive(
      {Duration polling = const Duration(seconds: 1)}) async* {
    while (true) {
      final response = await getMessages();

      for (final message in response) {
        if (message.whichTypeOfMessage() ==
            GenericMessage_TypeOfMessage.initialExchange) {
          final result = shouldAddContact?.call(message.initialExchange);

          if (result ?? false) {
            final contact = Contact(
                Uint8List.fromList(message.initialExchange.publicKey),
                message.initialExchange.name);
            addressBook.addContact(message.initialExchange.id, contact);
          }

          continue;
        }

        try {
          final result = await cryptographicProtocol
              .decryptSigned(Uint8List.fromList(message.payload));
          message.payload = List<int>.from(result.message);
          yield (result.sender, message);
        } on UnknowSender {
          continue;
        } on VerificationFailed {}
      }
      await Future.delayed(polling);
    }
  }

  Future<JWTResponse> getToken() async {
    if (client == null) {
      throw ClientNotConnected();
    }
    var uuid = Uuid();
    SignatureRequestDetail detail = SignatureRequestDetail(requestId: uuid.v4(), fingerPrint: cryptographicProtocol.getMyFingerprint(), requestTime: Int64((DateTime.now().millisecondsSinceEpoch)));
    final signedRequest = await cryptographicProtocol.sign(detail.writeToBuffer());

    final result = await client!.validateSignature(SignatureRequest(
        protocol: protocol,
        version: version,
        proof: signedRequest, detail: detail,
        publicKey: cryptographicProtocol.getMyPublicKey()));
    store.storeToken(result.token);
    return result;
  }

  Future<List<GenericMessage>> getMessages() async {
    final result = await client!.getMessages(GetMessagesRequest(lastId: store.getLastId()));
    store.setLastId(result.lastId);
    
    return result.messages;

  }

  Future<bool> sendMessage(Contact recipient, Uint8List payload,
      {int applicationType = 0}) async {
    final cipther =
        await cryptographicProtocol.signAndEncrypt(payload, [recipient]);

    final result = await client!.putMessage(PutMessageRequest(
        recipientId: recipient.getFingerprint(protocol),
        message: GenericMessage(payload: cipther, type: applicationType)));

    return false;
  }

    Future<bool> sendGroupMessage(List<Contact> recipient, Uint8List payload,
      {int applicationType = 0}) async {
    final cipther =
        await cryptographicProtocol.signAndEncrypt(payload, recipient);

    final result = await client!.putGroupMessage(PutGroupMessageRequest(
        recipientsId: recipient.map((e) => e.getFingerprint(protocol),),
        message: GenericMessage(payload: cipther, type: applicationType)));

    return false;
  }
}


class Contact {
  Uint8List publicKey;

  String name;

  Contact(this.publicKey, this.name);

  String getFingerprint(Enum protocol) {
    if (protocol == Enum.OPENPGP) {
      return OpenPGPProtocol.contactToPublickey(this).fingerprint;
    }

    throw UnimplementedError();
  }
}

abstract class CryptographicProtocol {
  Future<Uint8List> signAndEncrypt(Uint8List message, List<Contact> contact);

  Future<Uint8List> sign(Uint8List message);

  bool validateSignature();

  Future<Uint8List> encrypt(Uint8List message, List<Contact> contact);

  Future<Uint8List> decrypt(Uint8List message);

  void decryptPrivateKey(String passphrase);

  Future<({Uint8List message, Contact sender})> decryptSigned(
      Uint8List message);

  String getMyFingerprint();

  Uint8List getMyPublicKey();
}

abstract class AddressBook {
  Future<Contact?> getContactFromId(String id);

  void addContact(String id, Contact contact);
}

class AddressBookInMemory implements AddressBook {
  Map<String, Contact> store = {};

  @override
  void addContact(String id, Contact contact) {
    store[id] = contact;
  }

  @override
  Future<Contact?> getContactFromId(String id) async {
    return store[id];
  }
}

class OpenPGPProtocol implements CryptographicProtocol {
  late PrivateKey privateKey;
  late PublicKey publicKey;
  AddressBook addressBook;

  static PublicKey contactToPublickey(Contact contact) {
    return PublicKey.fromPacketList(PacketList.packetDecode(contact.publicKey));
  }

  OpenPGPProtocol(Uint8List privateKey, this.addressBook) {
    this.privateKey =
        PrivateKey.fromPacketList(PacketList.packetDecode(privateKey));
   

    publicKey = this.privateKey.toPublic;
  }

  @override
  Future<Uint8List> decrypt(Uint8List message) async {
    final plaintext = await OpenPGP.decrypt(
        Message(PacketList.packetDecode(message)),
        decryptionKeys: [privateKey]);

    return plaintext.literalData!.data;
  }

  @override
  Future<Uint8List> encrypt(Uint8List message, List<Contact> contact) async {
    final encMessage = await OpenPGP.encrypt(
        await OpenPGP.createBinaryMessage(message),
        encryptionKeys: contact.map((c) => contactToPublickey(c)));

    return encMessage.packetList.encode();
  }

  @override
  Future<Uint8List> sign(Uint8List message) async {
    final signature = await (await OpenPGP.createBinaryMessage(message)).signDetached([privateKey]);
    return PacketList(signature.packets).encode();

  }

  @override
  Future<Uint8List> signAndEncrypt(Uint8List message, List<Contact> contact) async {
    final encSingMessage = await OpenPGP.encrypt(
        await OpenPGP.createBinaryMessage(message),
        encryptionKeys: contact.map((c) => contactToPublickey(c)),
        signingKeys: [privateKey]);
    return encSingMessage.packetList.encode();
  }

  @override
  bool validateSignature() {
    throw UnimplementedError();
  }

  @override
  String getMyFingerprint() {
    return publicKey.fingerprint;
  }

  @override
  Uint8List getMyPublicKey() {
    return publicKey.toPacketList().encode();
  }

  @override
  Future<({Uint8List message, Contact sender})> decryptSigned(
      Uint8List message) async {
    Message plaintext = await OpenPGP.decrypt(
        Message(PacketList.packetDecode(message)),
        decryptionKeys: [privateKey]);

    if (plaintext.signingKeyIDs.length > 1) {
      throw Exception("Not more thath one signingKey");
    }

    final signingKeyID =
        plaintext.signaturePackets.first.issuerFingerprint!.fingerprint;

    final contact = await addressBook.getContactFromId(signingKeyID);

    if (contact == null) {
      throw UnknowSender();
    }

    plaintext = await plaintext.verify([contactToPublickey(contact)]);

    final verification = plaintext.verifications.first;

    if (verification.verified &&
        verification.signature.packets.first.issuerFingerprint!.fingerprint ==
            signingKeyID) {
      return (message: plaintext.literalData!.data, sender: contact);
    }

    throw VerificationFailed();
  }
  
  @override
  void decryptPrivateKey(String passphrase) async {
    privateKey = await privateKey.decrypt(passphrase);
  }
  
}

abstract class Store {
  storeToken(String token);
  String? getToken();
  String getLastId();
  setLastId(String newId);

  bool isTokenValid() {
    String? token = getToken();

    if (token == null) return false;

    return !JwtDecoder.isExpired(token);
  }

  Uint8List getPrivateKey();
}

class InMemoryStore extends Store {
  String? token;

  Uint8List privateKey;

  String lastId = "0";

  InMemoryStore(this.privateKey);

  @override
  Uint8List getPrivateKey() {
    return privateKey;
  }

  @override
  String? getToken() {
    return token;
  }

  @override
  storeToken(String token) {
    this.token = token;
  }
  
  @override
  String getLastId() {
   return lastId;
  }
  
  @override
  setLastId(String newId) {
    lastId = newId;
  }
}
