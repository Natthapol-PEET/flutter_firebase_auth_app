import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_button.dart';
import 'package:flutter_firebase_auth_app/components/app_logo.dart';
import 'package:flutter_firebase_auth_app/components/app_text_form_field.dart';
import 'package:flutter_firebase_auth_app/components/app_verify_wrong.dart';
import 'package:flutter_firebase_auth_app/controllers/login_controller.dart';
import 'package:flutter_firebase_auth_app/core/colors.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/core/update_id.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                  'เข้าสู่ระบบ',
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
              controller: controller.passwordControllre,
            ),
            const SizedBox(height: 20),
            _forgotPassword(context),
            const SizedBox(height: 20),
            _showWrong(context),
            AppButton(
              text: 'เข้าสู่ระบบ',
              onPressed: controller.onClickLogin,
            ),
            const SizedBox(height: 20),
            _noAccount(context),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Row _noAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'คุณยังไม่มีบัญชีผู้ใช้งาน ?',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        InkWell(
          onTap: () => Get.offAllNamed(RoutePath.register),
          child: Text(
            'สมัครสมาชิก',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.lightBlue),
          ),
        ),
      ],
    );
  }

  Widget _showLoginFail(BuildContext context) {
    return GetBuilder<LoginController>(
      id: UpdateById.loginFail,
      builder: (cotnroller) {
        List<WrongModel> worng = controller.loginWrong;
        if (worng.isEmpty) return const SizedBox.shrink();
        return AppVerifyWrong(worng: worng);
      },
    );
  }

  Widget _showWrong(BuildContext context) {
    return GetBuilder<LoginController>(
      id: UpdateById.wrong,
      builder: (cotnroller) {
        List<WrongModel> worng = controller.worng;
        if (worng.isEmpty) return const SizedBox.shrink();
        return AppVerifyWrong(worng: worng);
      },
    );
  }

  Row _forgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            'ลืมรหัสผ่าน',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
