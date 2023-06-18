import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:confidential_communication/protobuf/key_exchange/key_exchange.pb.dart';
import 'package:confidential_communication/protobuf/message_store/message_storage.pb.dart';
import 'package:confidential_communication/protobuf/message_store/message_storage.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';


class MessageDecrypted {

  final Uint8List message;
  final IdentityKey identityKey;
  final SignalProtocolAddress address;

  MessageDecrypted(this.message, this.identityKey, this.address);
  
}

Uint8List getKeyFromEC(ECPublicKey publicKey) {
  return (publicKey as DjbECPublicKey).publicKey;
}

class Address implements SignalProtocolAddress {
  final String? name;

  Address(this.remotePublicKey, {this.name});

  final Uint8List remotePublicKey;

  // We not use different device for now
  @override
  int getDeviceId() {
    return 1;
  }

  @override
  String getName() {
    if (name != null) {
      return name!;
    } else {
      return base64Encode(remotePublicKey);
    }
  }
}

class Persistence {
  SignalProtocolStore signalProtocolStore;

  Persistence(this.signalProtocolStore);

  Persistence.inMemory(IdentityKeyPair identityKeyPair, int registrationId)
      : signalProtocolStore = InMemorySignalProtocolStore(identityKeyPair, registrationId);
}

class ConfidentialCommunication {
  Persistence persistence;
  ClientChannel clientChannel;

  MessageStorageClient client;

  ConfidentialCommunication(this.persistence, this.clientChannel)
      : client = MessageStorageClient(clientChannel) {}

  Future<void> send(Address address, Uint8List data) async {
    final sessionCipher = getSessionCipher(address);

    final message = await sessionCipher.encrypt(data);

    final response = await client.store(StoreRequest(
        destinationPublicKey: address.remotePublicKey,
        message: message.serialize()));
  }

  SessionCipher getSessionCipher(SignalProtocolAddress address) {
    
    return SessionCipher.fromStore(persistence.signalProtocolStore, address);
  }

  SessionBuilder getSessionBuilder(SignalProtocolAddress address) {
    return SessionBuilder.fromSignalStore(persistence.signalProtocolStore, address);
  }

  Stream<MessageDecrypted> receive(
      {Duration polling = const Duration(seconds: 1)}) async* {
    final publicKey = await getPublicKey();
    while (true) {
      final response = await client.gets(GetsRequest(publicKey: publicKey));

      for (final message in response.messages) {

        final encryptedMessage =  PreKeySignalMessage(Uint8List.fromList(message.message));

        final remoteAddress = Address(getKeyFromEC(encryptedMessage.getIdentityKey().publicKey));

        final sessioncipher = SessionCipher.fromStore(persistence.signalProtocolStore, remoteAddress);
        final plaintext = await sessioncipher.decrypt(encryptedMessage);
        
        yield MessageDecrypted(plaintext, encryptedMessage.identityKey, remoteAddress);
      }
      await Future.delayed(polling);
    }
  }

  Future<Uint8List> getPublicKey() async {
    return ((await persistence.signalProtocolStore.getIdentityKeyPair())
            .getPublicKey().publicKey as DjbECPublicKey)
        .publicKey;
  }

  Future<Uint8List> initialKeyExchange({bool insecureChannel = false}) async {
    final publicKey = await getPublicKey();
    final registrationId =
        await persistence.signalProtocolStore.getLocalRegistrationId();
    final identityKeyPair =
        await persistence.signalProtocolStore.getIdentityKeyPair();

    PreKeyRecord? preKey;    
    if (insecureChannel){


    final preKeys = generatePreKeys(0, 1);

    final preKey = preKeys[0];

    await persistence.signalProtocolStore.storePreKey(preKey.id, preKey);

      }

    final signedPreKey = generateSignedPreKey(identityKeyPair, 0);

      
    await persistence.signalProtocolStore.storeSignedPreKey(
      signedPreKey.id, signedPreKey);

    return InitialKeyExchange(
            name: base64Encode(publicKey),
            registrationId: registrationId,
            preKeyId: insecureChannel ? preKey!.id : null,
            preKeyPublic: insecureChannel ? getKeyFromEC(preKey!.getKeyPair().publicKey) : null,
            signedPreKeyId: signedPreKey.id,
            signedPreKeyPublic:
                getKeyFromEC(signedPreKey.getKeyPair().publicKey),
            remoteIdentity:
                getKeyFromEC(identityKeyPair.getPublicKey().publicKey),
            signature: signedPreKey.signature)
        .writeToBuffer();
  }

  Future<Address> processInitialKeyExchange(Uint8List data) async {
    final initialkey = InitialKeyExchange.fromBuffer(data);

    final retrievedPreKey = PreKeyBundle(
      initialkey.registrationId,
      1,
      initialkey.hasPreKeyId() ? initialkey.preKeyId : null,
      initialkey.hasPreKeyPublic() ? DjbECPublicKey(Uint8List.fromList(initialkey.preKeyPublic.sublist(0))) : null,
      initialkey.signedPreKeyId,
      DjbECPublicKey(Uint8List.fromList(initialkey.signedPreKeyPublic.sublist(0))),
      Uint8List.fromList(initialkey.signature),
      IdentityKey(DjbECPublicKey(Uint8List.fromList(initialkey.remoteIdentity.sublist(0)))),
);

  final remoteAddress = Address(Uint8List.fromList(initialkey.remoteIdentity));

  final sessionBuilder = getSessionBuilder(remoteAddress);
  await sessionBuilder.processPreKeyBundle(retrievedPreKey);

  return remoteAddress;

  }
}
