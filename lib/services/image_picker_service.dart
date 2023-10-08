import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends GetxService {
  ImagePicker? _picker;

  @override
  void onInit() {
    _picker = ImagePicker();
    super.onInit();
  }

  Future<XFile?> pickOneImage({required ImageSource source}) async {
    return await _picker?.pickImage(source: source);
  }
}
