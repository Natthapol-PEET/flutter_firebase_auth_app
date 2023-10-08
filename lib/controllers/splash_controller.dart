import 'dart:async';

import 'package:flutter_firebase_auth_app/components/dialog/app_dialog.dart';
import 'package:flutter_firebase_auth_app/core/controller_base.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/share_key.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  FireStoreDatabaseService fireStore = Get.find<FireStoreDatabaseService>();

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => hasUsername());
    super.onInit();
  }

  void hasUsername() {
    String? user = prefs.getString(key: ShareKey.username);

    if (user == null) {
      Get.offAllNamed(RoutePath.login);
      return;
    }

    goToHome(user);
  }

  void goToHome(String user) async {
    try {
      List<UserModel> listUserModel = await fireStore.getUser(user);

      if (listUserModel.isEmpty) {
        Get.offAllNamed(RoutePath.login);
      } else {
        Get.offAllNamed(RoutePath.home, arguments: listUserModel[0]);
      }
    } catch (e) {
      AppDialog.showError(
        title: 'แจ้งเตือน',
        desc: 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต',
        btnOkOnPress: () {},
      );
    }
  }
}
