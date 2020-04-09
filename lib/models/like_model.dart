import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class LikeModel {
  int likeId;

  int postId;

  int userId;

  LikeModel(
      {
        this.likeId,
        @required this.postId,
        @required this.userId});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      likeId: json["id"],
      postId: json["post"],
      userId: json["user_id"]
    );
  }

}
