import 'package:euphoriafx/models/comment_model.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:flutter/cupertino.dart';

class UserPostModel {
  int userId;

  String imagePath;

  String username;

  String email;
  int typeId;

  List<PostModel> posts;

  List<CommentModel> comments;

  UserPostModel(
      {this.userId,
      @required this.username,
      @required this.email,
      this.typeId,
      this.imagePath,
      this.comments,
      this.posts
      });

  factory UserPostModel.fromJson(Map<String, dynamic> json) {

    var commentListFromJson = json["comments"] as List;

    List<CommentModel> commentList =
        commentListFromJson.map((comment) => CommentModel.fromJson(comment)).toList();

    var postListFromJson = json["feeds"] as List;

    List<PostModel> postList =
        postListFromJson.map((post) => PostModel.fromJson(post)).toList();

    return UserPostModel(
        userId: json["id"],
        username: json["username"],
        email: json["email"],
        typeId: json["type_id"],
        imagePath: json["image_path"],
        posts: postList,
        comments: commentList
    );
  }
}
