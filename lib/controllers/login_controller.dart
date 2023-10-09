import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/dialog/app_dialog.dart';
import 'package:flutter_firebase_auth_app/components/loading/app_loading_process.dart';
import 'package:flutter_firebase_auth_app/core/controller_base.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/share_key.dart';
import 'package:flutter_firebase_auth_app/core/update_id.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:flutter_firebase_auth_app/stores/user_store.dart';
import 'package:flutter_firebase_auth_app/utils/crypto_util.dart';
import 'package:flutter_firebase_auth_app/utils/regex_verify_util.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  FireStoreDatabaseService fireStore = Get.find<FireStoreDatabaseService>();
  CrytoUtil cryto = Get.find<CrytoUtil>();
  UserStore userStore = Get.find<UserStore>();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordControllre = TextEditingController();

  List<WrongModel> worng = [];
  List<WrongModel> loginWrong = [];

  void onClickLogin() {
    worng.clear();
    loginWrong.clear();

    List<String> user = VerifyUtil.username(userController.text);
    if (user.isNotEmpty) {
      worng.add(WrongModel(
        title: 'Username',
        description: user,
      ));
    }

    List<String> passwd = VerifyUtil.password(passwordControllre.text);
    if (passwd.isNotEmpty) {
      worng.add(WrongModel(
        title: 'Password',
        description: passwd,
      ));
    }

    FocusManager.instance.primaryFocus?.unfocus();
    update([UpdateById.wrong, UpdateById.loginFail]);
    if (worng.isEmpty) loginUser();
  }

  void loginUser() async {
    AppLoadingProcess.show();

    try {
      List<UserModel> listUserModel =
          await fireStore.getUser(userController.text);
      if (listUserModel.isEmpty) {
        _loginWrong();
      } else {
        bool verifyPassword =
            cryto.verify(passwordControllre.text, listUserModel[0].password!);
        if (verifyPassword) {
          userStore.userModel = listUserModel[0];
          prefs.setString(
              key: ShareKey.username, value: listUserModel[0].username!);
          Get.offAllNamed(RoutePath.home);
        } else {
          _loginWrong();
        }
      }
      AppLoadingProcess.cancel();
    } catch (e) {
      AppLoadingProcess.cancel();
      AppDialog.showError(
        title: 'แจ้งเตือน',
        desc: 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต',
        btnOkOnPress: () {},
      );
    }
  }

  void _loginWrong() {
    loginWrong.add(WrongModel(
      title: 'Login fail',
      description: ['username หรือ password ไม่ถูกต้อง !!'],
    ));
    update([UpdateById.wrong, UpdateById.loginFail]);
  }

  @override
  void onClose() {
    userController.dispose();
    passwordControllre.dispose();
    super.onClose();
  }
}
