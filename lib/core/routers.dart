import 'package:flutter_firebase_auth_app/bindings/change_password_binding.dart';
import 'package:flutter_firebase_auth_app/bindings/home_binding.dart';
import 'package:flutter_firebase_auth_app/bindings/login_binding.dart';
import 'package:flutter_firebase_auth_app/bindings/register_binding.dart';
import 'package:flutter_firebase_auth_app/bindings/splash_binding.dart';
import 'package:flutter_firebase_auth_app/views/change_password_screen.dart';
import 'package:flutter_firebase_auth_app/views/home_screen.dart';
import 'package:flutter_firebase_auth_app/views/login_screen.dart';
import 'package:flutter_firebase_auth_app/views/register_screen.dart';
import 'package:flutter_firebase_auth_app/views/splash_screen.dart';
import 'package:get/get.dart';

class RoutePath {
  static String splash = '/splash';
  static String login = '/login';
  static String register = '/register';
  static String home = '/home';
  static String changePassword = '/change_password';
}

class AppRouter {
  static List<GetPage<dynamic>> all = [
    GetPage(
      name: RoutePath.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutePath.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutePath.register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RoutePath.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutePath.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
