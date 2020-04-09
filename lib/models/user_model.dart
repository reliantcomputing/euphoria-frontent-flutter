import 'package:euphoriafx/config/constants.dart';
import 'package:euphoriafx/models/comment_model.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:euphoriafx/models/status_model.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  int userId;

  String imagePath;

  String username;

  String email;
  int typeId;

  UserModel(
      {this.userId,
      @required this.username,
      @required this.email,
      this.typeId,
      this.imagePath
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
        userId: json["id"],
        username: json["username"],
        email: json["email"],
        typeId: json["type_id"],
        imagePath: json["image_path"]
    );
  }
}
