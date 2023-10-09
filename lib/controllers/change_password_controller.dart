import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/dialog/app_dialog.dart';
import 'package:flutter_firebase_auth_app/components/loading/app_loading_process.dart';
import 'package:flutter_firebase_auth_app/core/controller_base.dart';
import 'package:flutter_firebase_auth_app/core/update_id.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:flutter_firebase_auth_app/stores/user_store.dart';
import 'package:flutter_firebase_auth_app/utils/crypto_util.dart';
import 'package:flutter_firebase_auth_app/utils/regex_verify_util.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  CrytoUtil cryto = Get.find<CrytoUtil>();
  FireStoreDatabaseService fireStore = Get.find<FireStoreDatabaseService>();
  UserStore userStore = Get.find<UserStore>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  List<WrongModel> worng = [];

  void onclickChangePassword() {
    worng.clear();

    List<String> passwd = VerifyUtil.password(passwordController.text);
    if (passwd.isNotEmpty) {
      worng.add(WrongModel(
        title: 'Current Password',
        description: passwd,
      ));
    } else {
      bool verifyPassword =
          cryto.verify(passwordController.text, userStore.userModel?.password ?? '');

      if (!verifyPassword) {
        worng.add(WrongModel(
          title: 'Current Password',
          description: ['รหัสผ่านไม่ถูกต้อง'],
        ));
      } else {
        List<String> newPasswd =
            VerifyUtil.password(newPasswordController.text);
        if (newPasswd.isNotEmpty) {
          worng.add(WrongModel(
            title: 'New Password',
            description: newPasswd,
          ));
        }

        if (newPasswordController.text != confirmPasswordController.text) {
          worng.add(WrongModel(
            title: 'Confirm Password',
            description: ['รหัสผ่านไม่ตรงกัน'],
          ));
        }
      }
    }

    FocusManager.instance.primaryFocus?.unfocus();
    update([UpdateById.wrong]);
    if (worng.isEmpty) changePassword();
  }

  void changePassword() async {
    UserModel userModel = userStore.userModel!;
    userModel.password = cryto.hash(newPasswordController.text);
    userModel.updatedAt = Timestamp.now();

    AppLoadingProcess.show();
    try {
      await fireStore.updateUser(userModel);
      userStore.userModel = userModel;
      AppLoadingProcess.cancel();
      AppDialog.showSuccess(
          title: 'เสร็จสิน',
          desc: 'เปลี่ยนรหัสผ่านสำเร็จ',
          btnOkOnPress: () => Get.back());
    } catch (e) {
      AppLoadingProcess.cancel();
      AppDialog.showError(
        title: 'แจ้งเตือน',
        desc: 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต',
        btnOkOnPress: () {},
      );
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
