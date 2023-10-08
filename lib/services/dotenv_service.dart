import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DotEnvService extends GetxService {
  @override
  void onInit() async {
    await dotenv.load(fileName: ".env");
    super.onInit();
  }

  String? get secretKey => dotenv.env['SECRET'];
}
