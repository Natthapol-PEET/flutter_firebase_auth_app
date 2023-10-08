import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageService extends GetxService {
  FirebaseStorage? _storage;

  @override
  void onInit() {
    _storage = FirebaseStorage.instance;
    super.onInit();
  }

  Future<String?> uploadImage(XFile xfile) async {
    var date = DateTime.now().millisecondsSinceEpoch;

    Reference? storageRef = _storage?.ref('uploads/photos/');
    Reference? mountainsRef = storageRef?.child('${date.toString()}_image.png');

    String filePath = xfile.path;
    File file = File(filePath);
    String? url;

    try {
      await mountainsRef?.putFile(file);
      url = await mountainsRef?.getDownloadURL();
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return url;
  }
}
