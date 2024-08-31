import 'dart:typed_data';
import 'package:confidential_communication/src/generated/service.pb.dart';
import 'package:confidential_communication/src/cryptography_protocol/openpgp.dart';

class Contact {
  Uint8List publicKey;

  String name;

  Contact(this.publicKey, this.name);

  String getFingerprint(Enum protocol) {
    if (protocol == Enum.OPENPGP) {
      return OpenPGPProtocol.contactToPublickey(this).fingerprint;
    }

    throw UnimplementedError();
  }
}
