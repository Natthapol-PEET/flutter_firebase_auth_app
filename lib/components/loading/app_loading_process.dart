import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_loading.dart';
import 'package:get/get.dart';

class AppLoadingProcess {
  static bool _loading = false;

  static void show() {
    _loading = true;

    Get.dialog(
      Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white.withOpacity(0.05),
        child: const Align(
          child: AppLoading(),
        ),
      ),
    );
  }

  static void cancel() {
    if (_loading) Get.back();
    _loading = false;
  }

  static bool get isLoading => _loading;
}
