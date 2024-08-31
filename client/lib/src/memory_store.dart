import 'dart:typed_data';

import 'package:confidential_communication/confidential_communication.dart';

class InMemoryStore extends Store {
  String? token;

  Uint8List privateKey;

  String lastId = "0";

  InMemoryStore(this.privateKey);

  @override
  Uint8List getPrivateKey() {
    return privateKey;
  }

  @override
  String? getToken() {
    return token;
  }

  @override
  storeToken(String token) {
    this.token = token;
  }
  
  @override
  String getLastId() {
   return lastId;
  }
  
  @override
  setLastId(String newId) {
    lastId = newId;
  }
}