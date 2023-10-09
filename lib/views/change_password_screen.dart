import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_button.dart';
import 'package:flutter_firebase_auth_app/components/app_logo.dart';
import 'package:flutter_firebase_auth_app/components/app_text_form_field.dart';
import 'package:flutter_firebase_auth_app/components/app_verify_wrong.dart';
import 'package:flutter_firebase_auth_app/controllers/change_password_controller.dart';
import 'package:flutter_firebase_auth_app/core/update_id.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'ย้อนกลับ',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            const AppLogo(),
            const SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'เปลี่ยนรหัสผ่าน',
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
              ],
            ),
            const SizedBox(height: 16),

            AppTextFormField(
              hintText: 'Current Password',
              isPassword: true,
              controller: controller.passwordController,
            ),
            // const SizedBox(height: 20),
            const Divider(height: 30, color: Colors.grey),
            AppTextFormField(
              hintText: 'New Password',
              isPassword: true,
              controller: controller.newPasswordController,
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'Confirm Password',
              isPassword: true,
              controller: controller.confirmPasswordController,
            ),
            const SizedBox(height: 20),
            _showWrong(context),
            AppButton(
              text: 'ยืนยัน',
              onPressed: controller.onclickChangePassword,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _showWrong(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      id: UpdateById.wrong,
      builder: (cotnroller) {
        List<WrongModel> worng = controller.worng;
        if (worng.isEmpty) return const SizedBox.shrink();
        return AppVerifyWrong(worng: worng);
      },
    );
  }
}
