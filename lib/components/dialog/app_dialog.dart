import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class AppDialog {
  static bool _dialogOpen = false;

  static void showSuccess({
    required String title,
    required String desc,
    void Function()? btnCancelOnPress,
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    ).show();
    _dialogOpen = true;
  }

  static void showWarning({
    required String title,
    required String desc,
    void Function()? btnCancelOnPress,
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    ).show();
    _dialogOpen = true;
  }

  static void showError({
    required String title,
    required String desc,
    void Function()? btnCancelOnPress,
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    ).show();
    _dialogOpen = true;
  }

  static void cancel() {
    if (_dialogOpen) Get.back();
    _dialogOpen = false;
  }

  static bool get isDialogOpen => _dialogOpen;
}
