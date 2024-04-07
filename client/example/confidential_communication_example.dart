import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/src/generated/service.pbgrpc.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:grpc/grpc.dart';

void main() async {
const passphrase = 'secret stuff';
final userID = ["asdasd", '(adasd)', '<test@test.com>'].join(' ');
final privateKey = await OpenPGP.generateKey(
    [userID],
    passphrase,
    type: KeyGenerationType.eddsa,
);


ConfidentialCommunication(InMemoryStore(privateKey.keyPacket.encode()), 'tesatasdt');
  

final publicKey = privateKey.toPublic;

print(publicKey.fingerprint);

final signedMessage = await OpenPGP.sign("asdasda",[privateKey], );
print(signedMessage.verifications);

final resutl = await OpenPGP.verify(signedMessage.armor(), [publicKey]);




final test = "asdas";
final encryptedMessage = await OpenPGP.encrypt(
    await OpenPGP.createTextMessage(test), encryptionKeys: [publicKey]
);
final encrypted = encryptedMessage.armor();

final testMessage = await encryptedMessage.compress(CompressionAlgorithm.zlib);

final testCOmpressd = testMessage.armor();
final decryptedMessage = await OpenPGP.decrypt(
    await OpenPGP.readMessage(encrypted), decryptionKeys: [privateKey]
);






}
