import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService extends GetxService {
  SharedPreferences? prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  Future<bool> setString({required String key, required String value}) async {
    return await prefs?.setString(key, value) as bool;
  }

  String? getString({required String key}) {
    return prefs?.getString(key);
  }

  Future<bool> remove({required String key}) async {
    return await prefs?.remove(key) as bool;
  }
}
