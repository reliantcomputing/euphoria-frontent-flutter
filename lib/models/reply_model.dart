import 'package:flutter/cupertino.dart';

class ReplyModel {
  int id;

  String reply;

  DateTime createdAt;

  DateTime updatedAt;

  int commentId;

  //The user that wrote the reply
  int userId;

  ReplyModel(
      {this.id,
      @required this.reply,
      this.createdAt,
      this.updatedAt,
      @required this.commentId,
      @required this.userId});

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      id: json['id'],
      reply: json['reply'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      commentId: json['comment_id'],
      userId: json['user_id'],
    );
  }
}
