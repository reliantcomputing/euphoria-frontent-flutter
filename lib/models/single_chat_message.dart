class SingleChatMessageModel {
  int messageId;
  String message;
  bool seen;
  int userId;
  int chatId;
  DateTime createdAt;

  SingleChatMessageModel({
    this.chatId,
    this.messageId,
    this.message,
    this.seen,
    this.createdAt,
    this.userId
  });

  factory SingleChatMessageModel.fromJson(Map<String, dynamic> json) {
    return SingleChatMessageModel(
        messageId: json["id"],
        message: json["message"],
        seen: json["seen"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]));
  }
}
