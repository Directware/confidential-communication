import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:confidential_communication/src/generated/service.pb.dart';
import 'package:confidential_communication/src/generated/service.pbgrpc.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:grpc/grpc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ClientNotConnected implements Exception {}

class ConfidentialCommunication {

  static const int version = 1;
  Store store;
  String passphrase;
  String? address;
  int? port;
  Enum protocol;
  

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
  }


  Future<JWTResponse> getToken()async {
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

  Future<bool> sendMessage(String recipientId, List<int> payload) async {

    if(!store.isTokenValid()){
      await getToken();
    }

    final result = await client!.putMessage(PutMessageRequest(recipientId: recipientId, message: GenericMessage(payload: payload)));

    return false;
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

  PrivateKey getPrivateKey(String passphrase);

}


