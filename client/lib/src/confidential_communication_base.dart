import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/src/generated/service.pb.dart';
import 'package:confidential_communication/src/generated/service.pbgrpc.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:dart_pg/src/packet/packet_list.dart';
import 'package:grpc/grpc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ClientNotConnected implements Exception {}

extension RandomExtensions on Random {
  int get nextByte => nextInt(256);
  
  Uint8List nextBytes(int length) {
    final result = Uint8List(length);
    for (var i=0; i<length; i++) {
      result[i] = nextByte;
    }
    return result;
  }
}

class ConfidentialCommunication {

  static const int version = 1;
  Store store;
  String passphrase;
  String? address;
  int? port;
  Enum protocol;
  late CryptographicProtocol cryptographicProtocol;

  bool Function(InitialExchange)? shouldAddContact;
  

  MessageServiceClient? client;

  ConfidentialCommunication(Store this.store, String this.passphrase,
      {String? this.address, int? this.port, this.protocol = Enum.OPENPGP}) {
    if (address != null) {
      final channel = ClientChannel(
        address!,
        port: port ?? 443,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      client = MessageServiceClient(channel);
    }

    if(protocol == Enum.OPENPGP){
      cryptographicProtocol = OpenPGPProtocol(store.getPrivateKey(passphrase));
    }
  }



  Future<InitialExchange> initialExchange(String name) async {

    var secureRandom = Random.secure();

    final challenge = secureRandom.nextBytes(16);

    return InitialExchange(name: name, id: cryptographicProtocol.getMyFingerprint(), publicKey: cryptographicProtocol.getMyPublicKey(), 
    protocol: protocol, version: version, isPayloadEncrypted: false, serverURL: "$address:$port", challenge: challenge
    );

  }


  Stream<(Contact, GenericMessage)> receive(
      {Duration polling = const Duration(seconds: 1)}) async* {
    while (true) {
      final response = await getMessages();

      for (final message in response) {
        if (message.whichTypeOfMessage() == GenericMessage_TypeOfMessage.initialExchange){
          shouldAddContact?.call(message.initialExchange);

        }
        //TODO retrive contact 
        message.payload = await cryptographicProtocol.decrypt(Uint8List.fromList(message.payload));
        yield message;
      }
      await Future.delayed(polling);
    }
  }

  


  Future<JWTResponse> getToken() async {
    if(client == null){
        throw ClientNotConnected();
    }
    final result = await client!.validateSignature(SignatureRequest(protocol: protocol, version: version, proof: List.empty()));
    store.storeToken(result.token);
    return result;
  }

  Future<List<GenericMessage>> getMessages() async {
    return List.empty();
  }

  Future<bool> sendMessage(Contact recipient, Uint8List payload, {int applicationType = 0}) async {
    final cipther = await cryptographicProtocol.encrypt(payload, recipient);

    if(!store.isTokenValid()){
      await getToken();
    }

    final result = await client!.putMessage(PutMessageRequest(recipientId: recipient.getFingerprint(protocol), message: GenericMessage(payload: cipther,type: applicationType)));

    return false;
  }



}

class Contact {
  Uint8List publicKey;

  String name;

  Contact(this.publicKey, this.name);


  String getFingerprint(Enum protocol){

    if(protocol == Enum.OPENPGP){
      return OpenPGPProtocol.contactToPublickey(this).fingerprint;
    }

    throw UnimplementedError();
 

  }

}

abstract class CryptographicProtocol {

  Future<Uint8List> signAndEncrypt(Uint8List message, Contact contact); 

  Future<Uint8List> sign(Uint8List message);

  bool validateSignature();

  Future<Uint8List> encrypt(Uint8List message, Contact contact);

  Future<Uint8List> decrypt(Uint8List message);

  String getMyFingerprint();

  Uint8List getMyPublicKey();

}


class OpenPGPProtocol implements CryptographicProtocol{


  late PrivateKey privateKey;
  late PublicKey publicKey;

  static PublicKey contactToPublickey(Contact contact) {
      return PublicKey.fromPacketList(PacketList.packetDecode(contact.publicKey));
  }


  OpenPGPProtocol(Uint8List privateKey){
    this.privateKey = PrivateKey.fromPacketList(PacketList.packetDecode(privateKey));
    publicKey = this.privateKey.toPublic;
  }

  @override
  Future<Uint8List> decrypt(Uint8List message) async {
    final plaintext = await OpenPGP.decrypt(
    Message(PacketList.packetDecode(message)), decryptionKeys: [privateKey]);



    return plaintext.literalData!.data;

  }

  @override
  Future<Uint8List> encrypt(Uint8List message, Contact contact) async {
    final encMessage = await OpenPGP.encrypt(
      await OpenPGP.createBinaryMessage(message), encryptionKeys: [contactToPublickey(contact)]
    );

  return encMessage.packetList.encode();
  }

  @override
  Future<Uint8List> sign(Uint8List message) async {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> signAndEncrypt(Uint8List message, Contact contact) async {
    throw UnimplementedError();
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

}


abstract class Store {

  storeToken(String token);
  String? getToken();
  bool isTokenValid() {

    String? token = getToken();

    if(token == null)return false;

    return JwtDecoder.isExpired(token);
  }

  Uint8List getPrivateKey(String passphrase);

}

class InMemoryStore extends Store{

  String? token;

  Uint8List privateKey;

  InMemoryStore(this.privateKey);

  @override
  Uint8List getPrivateKey(String passphrase) {
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


}