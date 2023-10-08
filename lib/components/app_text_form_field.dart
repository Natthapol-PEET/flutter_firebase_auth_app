import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/core/colors.dart';
import 'package:get/get.dart';

class AppTextFormFieldController extends GetxController {
  RxBool hidden = true.obs;

  void toggle() {
    hidden.toggle();
    update();
  }
}

class AppTextFormField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  const AppTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppTextFormFieldController>(
      global: false,
      init: AppTextFormFieldController(),
      builder: (appController) {
        return TextFormField(
          initialValue: initialValue,
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          keyboardType: keyboardType,
          maxLength: maxLength,
          obscureText: isPassword ? appController.hidden.value : false,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400, color: AppColors.greyShade900),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400, color: Colors.grey.shade400),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: appController.toggle,
                      icon: appController.hidden.isTrue
                          ? const Icon(Icons.visibility_off_outlined,
                              color: Colors.grey)
                          : const Icon(Icons.visibility_outlined,
                              color: Colors.grey))
                  : null),
        );
      },
    );
  }
}
