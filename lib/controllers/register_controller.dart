import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/dialog/app_dialog.dart';
import 'package:flutter_firebase_auth_app/components/loading/app_loading_process.dart';
import 'package:flutter_firebase_auth_app/core/controller_base.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/update_id.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';
import 'package:flutter_firebase_auth_app/services/firestore_database_service.dart';
import 'package:flutter_firebase_auth_app/services/image_picker_service.dart';
import 'package:flutter_firebase_auth_app/services/storage_service.dart';
import 'package:flutter_firebase_auth_app/utils/crypto_util.dart';
import 'package:flutter_firebase_auth_app/utils/regex_verify_util.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends BaseController {
  ImagePickerService picker = Get.find<ImagePickerService>();
  StorageService store = Get.find<StorageService>();
  FireStoreDatabaseService fireStore = Get.find<FireStoreDatabaseService>();
  CrytoUtil cryto = Get.find<CrytoUtil>();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordControllre = TextEditingController();
  TextEditingController confirmPsswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<WrongModel> worng = [];
  List<WrongModel> registerWrong = [];
  RxString uploadImageUrl = ''.obs;

  void onClickRegiser() async {
    worng.clear();
    registerWrong.clear();

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

    if (passwordControllre.text != confirmPsswordController.text) {
      worng.add(WrongModel(
        title: 'Confirm Password',
        description: <String>['รหัสผ่านไม่ตรงกัน'],
      ));
    }

    if (fullnameController.text.isEmpty) {
      worng.add(WrongModel(
        title: 'ชื่อ - นามสกุล',
        description: <String>['ต้องไม่เป็นค่าว่าง'],
      ));
    }

    List<String> phone = VerifyUtil.phone(phoneController.text);
    if (phone.isNotEmpty) {
      worng.add(WrongModel(
        title: 'เบอร์โทรศัพท์',
        description: phone,
      ));
    }

    if (uploadImageUrl.value == '') {
      worng.add(WrongModel(
        title: 'รูปภาพ',
        description: <String>['กรุณาอัพโหลดรูปภาพ'],
      ));
    }

    FocusManager.instance.primaryFocus?.unfocus();
    update([UpdateById.wrong]);
    if (worng.isEmpty) registerUser();
  }

  void registerUser() async {
    UserModel userModel = UserModel(
      username: userController.text,
      password: cryto.hash(passwordControllre.text),
      fullName: fullnameController.text,
      phoneNumber: phoneController.text,
      profileUrl: uploadImageUrl.value,
      createdAt: Timestamp.now(),
    );

    AppLoadingProcess.show();
    try {
      bool hasUser = await fireStore.hasUsername(userModel.username ?? '');
      if (hasUser) {
        registerWrong.add(WrongModel(
          title: 'Register fail',
          description: ['มี username นี้อยู่แล้ว !!'],
        ));
        update([UpdateById.wrong, UpdateById.registerFail]);
        AppLoadingProcess.cancel();
      } else {
        await fireStore.registerUser(userModel.toJson());
        AppLoadingProcess.cancel();
        AppDialog.showSuccess(
          title: 'เสร็จสิน',
          desc: 'ลงทะเบียนสำเร็จ',
          btnOkOnPress: () => Get.offAllNamed(RoutePath.login),
        );
      }
    } catch (e) {
      AppLoadingProcess.cancel();
      AppDialog.showError(
        title: 'แจ้งเตือน',
        desc: 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต',
        btnOkOnPress: () {},
      );
    }
  }

  void pickImage({required ImageSource source}) async {
    if (Get.isBottomSheetOpen ?? false) Get.back();

    XFile? xfile;
    xfile = await picker.pickOneImage(source: source);
    if (xfile == null) {
      AppDialog.showWarning(
        title: 'แจ้งเตือน',
        desc: 'รูปภาพไม่ถูกต้อง',
        btnOkOnPress: () {},
      );
      return;
    }

    AppLoadingProcess.show();
    uploadImageUrl.value = await store.uploadImage(xfile) ?? '';
    AppLoadingProcess.cancel();

    if (uploadImageUrl.value == '') {
      AppDialog.showError(
        title: 'แจ้งเตือน',
        desc: 'อัปโหลดรูปภาพไม่สำเร็จ\nกรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต',
        btnOkOnPress: () {},
      );
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
