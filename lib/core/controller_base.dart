import 'package:flutter_firebase_auth_app/services/dotenv_service.dart';
import 'package:flutter_firebase_auth_app/services/share_preference_service.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  SharedPreferenceService prefs = Get.find<SharedPreferenceService>();
  DotEnvService dotEnv = Get.find<DotEnvService>();
}
