import 'package:flutter_firebase_auth_app/components/dialog/app_dialog.dart';
import 'package:flutter_firebase_auth_app/core/controller_base.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/share_key.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  UserModel get userModel => Get.arguments;

  void onClickLogout() {
    AppDialog.showWarning(
      title: 'แจ้งเตือน',
      desc: 'คุณต้องการออกจากระบบ ?',
      btnOkOnPress: _logout,
    );
  }

  void _logout() async {
    await prefs.remove(key: ShareKey.username);
    Get.offAllNamed(RoutePath.login);
  }
}
