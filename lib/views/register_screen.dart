import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_button.dart';
import 'package:flutter_firebase_auth_app/components/app_cached_network_mage.dart';
import 'package:flutter_firebase_auth_app/components/app_logo.dart';
import 'package:flutter_firebase_auth_app/components/app_text_form_field.dart';
import 'package:flutter_firebase_auth_app/components/app_verify_wrong.dart';
import 'package:flutter_firebase_auth_app/controllers/register_controller.dart';
import 'package:flutter_firebase_auth_app/core/colors.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/update_id.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: ListView(
          children: [
            const SizedBox(height: 100),
            const AppLogo(),
            const SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'สมัครสมาชิก',
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _showLoginFail(context),
            AppTextFormField(
              hintText: 'Username',
              controller: controller.userController,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'Password',
              isPassword: true,
              controller: controller.passwordController,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'Confirm Password',
              isPassword: true,
              controller: controller.confirmPsswordController,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'ชื่อ - นามสกุล',
              controller: controller.fullnameController,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'เบอร์โทรศัพท์',
              maxLength: 10,
              keyboardType: TextInputType.phone,
              controller: controller.phoneController,
            ),
            const SizedBox(height: 10),
            _uploadImage(context),
            const SizedBox(height: 20),
            _showWrong(context),
            AppButton(
              text: 'สมัครสมาชิก',
              onPressed: controller.onClickRegiser,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'คุณมีบัญชีผู้ใช้งานอยู่แล้ว ?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () => Get.offAllNamed(RoutePath.login),
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _showLoginFail(BuildContext context) {
    return GetBuilder<RegisterController>(
      id: UpdateById.registerFail,
      builder: (cotnroller) {
        List<WrongModel> worng = controller.registerWrong;
        if (worng.isEmpty) return const SizedBox.shrink();
        return AppVerifyWrong(worng: worng);
      },
    );
  }

  Widget _showWrong(BuildContext context) {
    return GetBuilder<RegisterController>(
      id: UpdateById.wrong,
      builder: (cotnroller) {
        List<WrongModel> worng = controller.worng;
        if (worng.isEmpty) return const SizedBox.shrink();
        return AppVerifyWrong(worng: worng);
      },
    );
  }

  Widget _uploadImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            width: Get.width,
            height: 200,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () =>
                      controller.pickImage(source: ImageSource.gallery),
                  child: Text(
                    'อัพโหลดภาพ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      controller.pickImage(source: ImageSource.camera),
                  child: Text(
                    'ถ่ายภาย',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'ยกเลิก',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
          isDismissible: false,
        );
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(() => controller.uploadImageUrl.value == ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey,
                    size: 45,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'อัพโหลดภาพถ่ายประจำตัว',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AppCachedNetworkImage(
                    imageUrl: controller.uploadImageUrl.value))),
      ),
    );
  }
}
