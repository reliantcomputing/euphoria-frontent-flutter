import 'package:euphoriafx/models/single_chat_message.dart';
import 'package:euphoriafx/models/user_model.dart';

class SingleChatModel {
  int chatId;

  int packageId;

  DateTime updatedAt;

  List<SingleChatMessageModel> messages;

  List<UserModel> users;

  SingleChatModel(
      {this.chatId, this.packageId, this.users, this.updatedAt, this.messages});

  factory SingleChatModel.fromJson(Map<String, dynamic> json) {
    var messageListFromJson = json["messages"] as List;

    List<SingleChatMessageModel> messageList = messageListFromJson
        .map((message) => SingleChatMessageModel.fromJson(message))
        .toList();

    var userListFromJson = json["users"] as List;

    List<UserModel> userList = userListFromJson
        .map((user) => UserModel.fromJson(user))
        .toList();

    return SingleChatModel(
        chatId: json["id"],
        packageId: json["package_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        messages: messageList,
        users: userList);
  }
}
