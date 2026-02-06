import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_two/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageUrl;

  UserModel({this.fullName, this.email, this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
    imageUrl = data['imageUrl'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(email: email, fullName: fullName, imageUrl: imageUrl);
  }
}
