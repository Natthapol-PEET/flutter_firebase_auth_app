import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? password;
  String? fullName;
  String? phoneNumber;
  String? profileUrl;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  UserModel({
    this.username,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.profileUrl,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['user_name'];
    password = json['password'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    profileUrl = json['profile_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  UserModel.fromDocument(QueryDocumentSnapshot<Object?> doc) {
    username = doc.get('user_name');
    password = doc.get('password');
    fullName = doc.get('full_name');
    phoneNumber = doc.get('phone_number');
    profileUrl = doc.get('profile_url');
    createdAt = doc.get('created_at');
    updatedAt = doc.get('updated_at');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = username;
    data['password'] = password;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['profile_url'] = profileUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
