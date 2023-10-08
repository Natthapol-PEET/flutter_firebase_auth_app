import 'package:flutter_firebase_auth_app/controllers/login_controller.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:flutter_firebase_auth_app/utils/crypto_util.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => FireStoreDatabaseService());
    Get.lazyPut(() => CrytoUtil());
  }
}
