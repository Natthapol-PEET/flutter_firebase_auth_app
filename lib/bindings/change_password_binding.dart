import 'package:flutter_firebase_auth_app/controllers/change_password_controller.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:flutter_firebase_auth_app/utils/crypto_util.dart';
import 'package:get/get.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FireStoreDatabaseService());
    Get.lazyPut(() => CrytoUtil());
    Get.lazyPut(() => ChangePasswordController());
  }
}
