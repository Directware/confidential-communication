
import 'dart:convert';

import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/src/generated/service.pb.dart';
import 'package:dart_pg/dart_pg.dart';

Future<ConfidentialCommunication> getBob() async {

    const passphrase = 'secret stuff';
    final userID = ["bob", '(adasd)', '<test@test.com>'].join(' ');
    final privateKey = await OpenPGP.generateKey(
      [userID],
      passphrase,
      type: KeyGenerationType.ecdsa,
      curve: CurveInfo.secp256k1

  );

  final addressBook = AddressBookInMemory();
  return ConfidentialCommunication(InMemoryStore(privateKey.toPacketList().encode()),addressBook, passphrase, address: "localhost", port: 50051);
}



Future<ConfidentialCommunication> getAlice() async {

    const passphrase = 'secret stuff';
    final userID = ["alice", '(adasd)', '<test@test.com>'].join(' ');
    final privateKey = await OpenPGP.generateKey(
      [userID],
      passphrase,
      type: KeyGenerationType.ecdsa,
      curve: CurveInfo.secp256k1

  );

  final addressBook = AddressBookInMemory();
  return ConfidentialCommunication(InMemoryStore(privateKey.toPacketList().encode()),addressBook, passphrase, address: "localhost", port: 50051);
}

void main() async {
  


final bob = await getBob();
final alice = await getAlice();



await alice.init();
await bob.init();


print("ready to send message");



final bobContact = Contact(bob.cryptographicProtocol.getMyPublicKey(), "bob");
final aliceContact = Contact(alice.cryptographicProtocol.getMyPublicKey(), "alice");


bob.addressBook.addContact(aliceContact.getFingerprint(Enum.OPENPGP), aliceContact);
alice.addressBook.addContact(bobContact.getFingerprint(Enum.OPENPGP), bobContact);


int counter = 0;
final testMessage = utf8.encode("ciao sono cifrato");

while (true) {
counter++;

final aliceMessage = await alice.cryptographicProtocol.signAndEncrypt(testMessage, [bobContact!]);
final result = await bob.cryptographicProtocol.decryptSigned(aliceMessage);

if (utf8.decode(result.message) != utf8.decode(testMessage)) {
  print("different message");
}
if (counter % 10 == 0) {
  print(counter);
}
}


}