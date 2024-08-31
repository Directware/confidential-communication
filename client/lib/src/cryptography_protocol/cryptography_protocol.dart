import 'dart:typed_data';

import 'package:confidential_communication/src/cryptography_protocol/contact.dart';

abstract class CryptographyProtocol {
  Future<Uint8List> signAndEncrypt(Uint8List message, List<Contact> contact);

  Future<Uint8List> sign(Uint8List message);

  bool validateSignature();

  Future<Uint8List> encrypt(Uint8List message, List<Contact> contact);

  Future<Uint8List> decrypt(Uint8List message);

  void decryptPrivateKey(String passphrase);

  Future<({Uint8List message, Contact sender})> decryptSigned(
      Uint8List message);

  String getMyFingerprint();

  Uint8List getMyPublicKey();
}