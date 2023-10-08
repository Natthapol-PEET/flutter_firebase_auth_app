import 'package:flutter_firebase_auth_app/services/dotenv_service.dart';
import 'package:flutter_firebase_auth_app/services/share_preference_service.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DotEnvService());
    Get.put(SharedPreferenceService());
  }
}
