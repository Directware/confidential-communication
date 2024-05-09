import 'dart:io';

import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/src/generated/service.pbgrpc.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:grpc/grpc.dart';

void main() async {

const passphrase = 'secret stuff';
final userID = ["bob", '(adasd)', '<test@test.com>'].join(' ');
final privateKey = await OpenPGP.generateKey(
    [userID],
    passphrase,
    type: KeyGenerationType.eddsa,
);


final addressBook = AddressBookInMemory();

final client = ConfidentialCommunication(InMemoryStore(privateKey.keyPacket.encode()),addressBook, passphrase, address: "localhost", port: 50051);


client.shouldAddContact = (initial) {
  return true;
};



var myFile = File('qrcode.txt');


client.processInitialExchange(GenericMessage.fromBuffer(myFile.readAsBytesSync()), "bob");

}
