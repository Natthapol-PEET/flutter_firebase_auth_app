import 'package:flutter_firebase_auth_app/components/dialog/app_dialog.dart';
import 'package:flutter_firebase_auth_app/core/controller_base.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/share_key.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:flutter_firebase_auth_app/stores/user_store.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  UserStore userStore = Get.find<UserStore>();
  UserModel? userModel;

  @override
  void onInit() {
    userModel = userStore.userModel;
    super.onInit();
  }

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
