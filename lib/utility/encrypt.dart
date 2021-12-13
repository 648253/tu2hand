import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';

class EncryptAndDecrypt {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    
    return encrypted;
  }

  static decryptAES(text) {
    return encrypter.decrypt(text, iv: iv);
  }
}
