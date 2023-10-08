import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_firebase_auth_app/services/dotenv_service.dart';
import 'package:get/get.dart';

class CrytoUtil {
  DotEnvService dotEnv = Get.find<DotEnvService>();

  String hash(String pwd) {
    List<int> key = utf8.encode(pwd);
    List<int> bytes = utf8.encode(dotEnv.secretKey ?? '');

    Hmac hmacSha256 = Hmac(sha256, key);
    Digest digest = hmacSha256.convert(bytes);
    return digest.toString();
  }

  bool verify(String pwd, String key) {
    return hash(pwd) == key;
  }
}
