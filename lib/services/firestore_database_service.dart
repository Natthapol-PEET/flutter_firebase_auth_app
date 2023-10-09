import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_auth_app/core/share_key.dart';
import 'package:flutter_firebase_auth_app/models/user_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FireStoreDatabaseService extends GetxService {
  FirebaseFirestore? _fireStore;

  @override
  void onInit() {
    _fireStore = FirebaseFirestore.instance;
    super.onInit();
  }

  Future<DocumentReference<Map<String, dynamic>>> registerUser(
      Map<String, dynamic> json) async {
    CollectionReference<Map<String, dynamic>>? users =
        _fireStore?.collection('users');

    DocumentReference<Map<String, dynamic>> resp = await users!.add(json);
    return resp;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> queryUser(key, value) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore!
        .collection('users')
        .where(key, isEqualTo: value)
        .get();

    return querySnapshot;
  }

  Future<void> updateUser(UserModel userModel) {
    CollectionReference<Map<String, dynamic>>? users =
        _fireStore?.collection('users');
    return users!.doc(userModel.docId).update(userModel.toJson());
  }

  Future<bool> hasUsername(String username) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await queryUser(ShareKey.username, username);

    int length = querySnapshot.docs.length;
    return length > 0;
  }

  Future<List<UserModel>> getUser(String username) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await queryUser(ShareKey.username, username);

    List<UserModel> listUser = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      listUser.add(UserModel.fromDocument(doc));
    }

    return listUser;
  }
}
