import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  var myFile = File('qrcode.txt');

  final initialkey = InitialKeyExchange.fromBuffer(myFile.readAsBytesSync());
  print((identityKeyPair.getPublicKey().publicKey as DjbECPublicKey).publicKey.length);
  print(initialkey.preKeyPublic.sublist(0).length);

   final retrievedPreKey = PreKeyBundle(
      initialkey.registrationId,
      1,
      initialkey.preKeyId,
      DjbECPublicKey(Uint8List.fromList(initialkey.preKeyPublic.sublist(0))),
      initialkey.signedPreKeyId,
      DjbECPublicKey(Uint8List.fromList(initialkey.signedPreKeyPublic.sublist(0))),
      Uint8List.fromList(initialkey.signature),
      IdentityKey(DjbECPublicKey(Uint8List.fromList(initialkey.remoteIdentity.sublist(0)))),
);


    const bobAddress = SignalProtocolAddress('bob', 1);

 final sessionBuilder = SessionBuilder(
      sessionStore, preKeyStore, signedPreKeyStore, identityStore, bobAddress);
  await sessionBuilder.processPreKeyBundle(retrievedPreKey);


  final sessionCipher = SessionCipher(
      sessionStore, preKeyStore, signedPreKeyStore, identityStore, bobAddress);

    final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
   final ciphertext = await sessionCipher
      .encrypt(Uint8List.fromList(utf8.encode('Hello Mixin')));
  // ignore: avoid_print
  print(ciphertext.serialize().length);

  final stub = MessageStorageClient(channel);

  final response = stub.store(StoreRequest(destinationPublicKey: initialkey.remoteIdentity, message: ciphertext.serialize()));
  print(await response.headers);
  print(await response);
  print(await response.trailers);



}