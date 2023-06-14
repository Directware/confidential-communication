import 'dart:io';

import 'package:confidential_communication/protobuf/key_exchange/key_exchange.pb.dart';
import 'package:confidential_communication/protobuf/message_store/message_storage.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';


Future<void> main() async {
 final identityKeyPair = generateIdentityKeyPair();
  identityKeyPair.getPrivateKey();

  
  final registrationId = generateRegistrationId(false);

  final preKeys = generatePreKeys(0, 110);

  final signedPreKey = generateSignedPreKey(identityKeyPair, 0);

  final sessionStore = InMemorySessionStore();
  final preKeyStore = InMemoryPreKeyStore();
  final signedPreKeyStore = InMemorySignedPreKeyStore();

  final identityStore =
      InMemoryIdentityKeyStore(identityKeyPair, registrationId);

  for (final p in preKeys) {
    await preKeyStore.storePreKey(p.id, p);
  }
  await signedPreKeyStore.storeSignedPreKey(signedPreKey.id, signedPreKey);

  final initialKey = InitialKeyExchange(name: "test", registrationId: registrationId, preKeyId: preKeys[0].id, preKeyPublic: (preKeys[0].getKeyPair().publicKey as DjbECPublicKey).publicKey, signedPreKeyId: signedPreKey.id, signedPreKeyPublic: ( signedPreKey.getKeyPair().publicKey as DjbECPublicKey).publicKey, remoteIdentity: (identityKeyPair.getPublicKey().publicKey as DjbECPublicKey).publicKey, signature: signedPreKey.signature);
  var myFile = File('qrcode.txt');

  myFile.writeAsBytesSync(initialKey.writeToBuffer());

    final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final stub = MessageStorageClient(channel);
  while (true) {
    final response = await stub.gets(GetsRequest(publicKey:(identityKeyPair.getPublicKey().publicKey as DjbECPublicKey).publicKey ));
    
    print(response.messages);
    await Future.delayed(Duration(seconds: 1));
  }  
}