import 'dart:convert';
import 'dart:io';

import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/src/generated/service.pbgrpc.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:grpc/grpc.dart';

void main() async {
const passphrase = 'secret stuff';
final userID = ["alice", '(adasd)', '<test@test.com>'].join(' ');
final privateKey = await OpenPGP.generateKey(
    [userID],
    passphrase,
    type: KeyGenerationType.eddsa,
);


final addressBook = AddressBookInMemory();

final client = ConfidentialCommunication(InMemoryStore(privateKey.toPacketList().encode()),addressBook, passphrase, address: "localhost", port: 50051);


client.shouldAddContact = (initial) {
  print("some one what send message to me ${initial.name}");
  return true;
};

var myFile = File('qrcode.txt');

myFile.writeAsBytesSync((await client.initialExchange("Alice")).writeToBuffer());


  client.receive().listen((event) {
    print("new message: from ${event.$1.name } data is ${utf8.decode(event.$2.payload)}");
    client.sendMessage(event.$1, utf8.encode("hello your message was ${utf8.decode(event.$2.payload)}"));
  });


}
