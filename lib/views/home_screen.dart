import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/components/app_button.dart';
import 'package:flutter_firebase_auth_app/components/app_cached_network_mage.dart';
import 'package:flutter_firebase_auth_app/components/app_text_form_field.dart';
import 'package:flutter_firebase_auth_app/controllers/home_controller.dart';
import 'package:flutter_firebase_auth_app/core/colors.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'เข้าสู่ระบบสำเร็จ',
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AppCachedNetworkImage(
                  imageUrl: controller.userModel.profileUrl ?? '',
                ),
              ),
              const SizedBox(height: 50),
              _title(context, text: 'ส่วนตัว'),
              const SizedBox(height: 10),
              AppTextFormField(
                initialValue: 'ชื่อ : ${controller.userModel.fullName}',
                readOnly: true,
              ),
              const Divider(color: Colors.grey, height: 0),
              AppTextFormField(
                initialValue: 'เบอร์โทร : ${controller.userModel.phoneNumber}',
                readOnly: true,
              ),
              const SizedBox(height: 20),
              _title(context, text: 'บัญชี'),
              const SizedBox(height: 10),
              AppTextFormField(
                initialValue: 'username : ${controller.userModel.username}',
                readOnly: true,
              ),
              const Divider(color: Colors.grey, height: 0),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  const AppTextFormField(
                    initialValue: 'password : ■ ■ ■ ■ ■',
                    readOnly: true,
                  ),
                  Positioned(
                    right: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'เปลี่ยนรหัสผ่าน',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightBlue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppButton(
                text: 'ล็อกเอ้า',
                onPressed: controller.onClickLogout,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Row _title(BuildContext context, {required String text}) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.titleMedium!),
      ],
    );
  }
}
