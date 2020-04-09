import 'package:euphoriafx/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class CommentModel {
  int commentId;

  String comment;

  DateTime createdAt;

  DateTime updatedAt;

  UserModel user;

  CommentModel(
      {
        this.commentId,
        @required this.comment,
        this.createdAt,
        this.updatedAt,
        @required this.user});

  factory CommentModel.fromJson(Map<String, dynamic> json){
    return CommentModel(
      commentId: json["id"],
      comment: json["comment"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      user: UserModel.fromJson(json["user"])
    );
  }
}
