import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/protobuf/key_exchange/key_exchange.pb.dart';
import 'package:confidential_communication/protobuf/message_store/message_storage.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';


Future<void> main() async {

 final identityKeyPair = generateIdentityKeyPair();
 final registrationId = generateRegistrationId(false);

 final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final com =  ConfidentialCommunication(Persistence.inMemory(identityKeyPair, registrationId), channel); 
 
  var myFile = File('qrcode.txt');

  final newAddress = await com.processInitialKeyExchange(myFile.readAsBytesSync());
  for (int i = 1; i < 10; i++) {
    await com.send(newAddress, Uint8List.fromList(utf8.encode("welcome to home $i")));
    await Future.delayed(Duration(seconds: 5));
  }

}