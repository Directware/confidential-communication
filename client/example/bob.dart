import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
    type: KeyGenerationType.ecdsa,
    curve: CurveInfo.secp256k1

);


final addressBook = AddressBookInMemory();


final client = ConfidentialCommunication(InMemoryStore(privateKey.toPacketList().encode()),addressBook, passphrase, address: "localhost", port: 50051);

await client.init();
client.shouldAddContact = (initial) {
  print(initial);
  return true;
};



var myFile = File('/home/razzo/Progetti/confidatial_comminication/client/qrcode.txt');


GenericMessage initialExchange = GenericMessage.fromBuffer(myFile.readAsBytesSync());

String aliceId = initialExchange.initialExchange.id;

client.processInitialExchange(initialExchange, "bob");

int counter = 0;


client.receive().listen((event) {
    print("new message: from ${event.$1.name } data is ${utf8.decode(event.$2.payload)}");
  });

while(true) {
  counter++;
  await Future.delayed(Duration(seconds: 1));
  print("send Message");


  final contact = await addressBook.getContactFromId(aliceId);

    if (contact != null) {
        client.sendMessage(contact, utf8.encode("hello $counter"));
    } else {
      print("no contact");
    }
}

}
