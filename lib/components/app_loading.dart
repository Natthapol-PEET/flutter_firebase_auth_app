import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/core/colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.green,
      backgroundColor: Colors.transparent,
    );
  }
}
