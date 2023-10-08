import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/core/colors.dart';

class AppLicence extends StatelessWidget {
  const AppLicence({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'APO.DEV',
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: AppColors.greyShade900),
    );
  }
}
