import 'dart:typed_data';

import 'package:confidential_communication/confidential_communication.dart';
import 'package:confidential_communication/src/cryptography_protocol/contact.dart';
import 'package:dart_pg/dart_pg.dart';
import 'package:dart_pg/src/packet/packet_list.dart';

import 'cryptography_protocol.dart';

class OpenPGPProtocol implements CryptographyProtocol {
  late PrivateKey privateKey;
  late PublicKey publicKey;
  AddressBook addressBook;

  static PublicKey contactToPublickey(Contact contact) {
    return PublicKey.fromPacketList(PacketList.packetDecode(contact.publicKey));
  }

  OpenPGPProtocol(Uint8List privateKey, this.addressBook) {
    this.privateKey =
        PrivateKey.fromPacketList(PacketList.packetDecode(privateKey));
   

    publicKey = this.privateKey.toPublic;
  }

  @override
  Future<Uint8List> decrypt(Uint8List message) async {
    final plaintext = await OpenPGP.decrypt(
        Message(PacketList.packetDecode(message)),
        decryptionKeys: [privateKey]);

    return plaintext.literalData!.data;
  }

  @override
  Future<Uint8List> encrypt(Uint8List message, List<Contact> contact) async {
    final encMessage = await OpenPGP.encrypt(
        await OpenPGP.createBinaryMessage(message),
        encryptionKeys: contact.map((c) => contactToPublickey(c)));

    return encMessage.packetList.encode();
  }

  @override
  Future<Uint8List> sign(Uint8List message) async {
    final signature = await (await OpenPGP.createBinaryMessage(message)).signDetached([privateKey]);
    return PacketList(signature.packets).encode();

  }

  @override
  Future<Uint8List> signAndEncrypt(Uint8List message, List<Contact> contact) async {
    final encSingMessage = await OpenPGP.encrypt(
        await OpenPGP.createBinaryMessage(message),
        encryptionKeys: contact.map((c) => contactToPublickey(c)),
        signingKeys: [privateKey]);

    return encSingMessage.packetList.encode();
  }

  @override
  bool validateSignature() {
    throw UnimplementedError();
  }

  @override
  String getMyFingerprint() {
    return publicKey.fingerprint;
  }

  @override
  Uint8List getMyPublicKey() {
    return publicKey.toPacketList().encode();
  }

  @override
  Future<({Uint8List message, Contact sender})> decryptSigned(
      Uint8List message) async {
    Message plaintext = await OpenPGP.decrypt(
        Message(PacketList.packetDecode(message)),
        decryptionKeys: [privateKey]);

    if (plaintext.signingKeyIDs.length > 1) {
      throw Exception("Not more thath one signingKey");
    }

    final signingKeyID =
        plaintext.signaturePackets.first.issuerFingerprint!.fingerprint;

    final contact = await addressBook.getContactFromId(signingKeyID);

    if (contact == null) {
      throw UnknowSender();
    }

    plaintext = await plaintext.verify([contactToPublickey(contact)]);


    if (plaintext.verifications.isEmpty) {
      throw VerificationFailed();
    }

    final verification = plaintext.verifications.first;

    if (verification.verified &&
        verification.signature.packets.first.issuerFingerprint!.fingerprint ==
            signingKeyID) {
      return (message: plaintext.literalData!.data, sender: contact);
    }

    throw VerificationFailed();
  }
  
  @override
  void decryptPrivateKey(String passphrase) async {
    privateKey = await privateKey.decrypt(passphrase);
  }
  
}