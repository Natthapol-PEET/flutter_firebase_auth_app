import 'package:flutter_firebase_auth_app/controllers/register_controller.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:flutter_firebase_auth_app/services/image_picker_service.dart';
import 'package:flutter_firebase_auth_app/services/storage_service.dart';
import 'package:flutter_firebase_auth_app/utils/crypto_util.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ImagePickerService());
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => FireStoreDatabaseService());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => CrytoUtil());
  }
}
