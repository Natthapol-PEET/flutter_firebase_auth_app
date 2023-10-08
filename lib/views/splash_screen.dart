import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_licence.dart';
import 'package:flutter_firebase_auth_app/components/app_loading.dart';
import 'package:flutter_firebase_auth_app/components/app_logo.dart';
import 'package:flutter_firebase_auth_app/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: const Stack(
          alignment: AlignmentDirectional.center,
          children: [
            AppLogo(),
            Positioned(
              bottom: 100,
              child: Column(
                children: [
                  AppLoading(),
                  SizedBox(height: 18),
                  AppLicence(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
