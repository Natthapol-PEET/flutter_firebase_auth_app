import 'package:flutter_firebase_auth_app/controllers/splash_controller.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FireStoreDatabaseService());
    Get.put(SplashController());
  }
}
