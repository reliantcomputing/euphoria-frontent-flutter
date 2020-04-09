import 'dart:core';

import 'package:euphoriafx/models/comment_model.dart';
import 'package:euphoriafx/models/image_model.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'like_model.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  int postId;

  String content;

  DateTime createdAt;

  DateTime updatedAt;

  String imagePath;

  UserModel user;

  List<CommentModel> comments;

  List<LikeModel> likes;

  PostModel(
      {this.postId,
      @required this.content,
      this.createdAt,
      this.updatedAt,
      this.comments,
      this.likes,
      this.imagePath,
      @required this.user});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var commentListFromJson = json["comments"] as List;

    List<CommentModel> commentList =
        commentListFromJson.map((comment) => CommentModel.fromJson(comment)).toList();

    var likeListFromJson = json["likes"] as List;

    List<LikeModel> likeList =
        likeListFromJson.map((like) => LikeModel.fromJson(like)).toList();

    return PostModel(
        postId: json["id"],
        content: json["content"],
        imagePath: json["image_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: UserModel.fromJson(json["user"]),
        comments: commentList,
        likes: likeList);
  }
}
