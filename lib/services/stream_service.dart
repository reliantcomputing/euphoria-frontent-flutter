import 'package:web_socket_channel/io.dart';

class StreamService{
  static final String socketUrl = "ws://192.168.43.14:8000/?session_key=None";
  final channel = IOWebSocketChannel.connect(socketUrl);

  // Return a list stream
  Map<String, dynamic> listStream(String stream, var requestId){
    var streamData = {
      "stream": stream,
      "payload": {
        "action": "list", 
        "request_id": requestId
      }
    };

    return streamData;
  }

  Map<String, dynamic> createStream(String stream, var requestId, var data){
        var streamData = {
        "stream": stream,
        "payload": {
        "action": "create", 
        "request_id": requestId,
        "data" : data
      }
    };

    return streamData;
  }

  // Streams names
  var usersStream = "users_stream";
  var postChildrenStream = "posts_children_stream";
  var postsStream = "posts_stream";
  var commentsStream = "comments_stream";
  var repliesStream = "replies_stream";
  var likesStream = "likes_stream";
  var teamNotificationsStream = "team_notifications_stream";
  var robotNotificationsStream = "robot_notifications_stream";
  var otherNotificationsStream = "other_notifications_stream";
  var singleChatsStream = "single_chats_stream";
  var singleChatsMessagesStream = "single_chats_messages_stream";
  var groupChatsStream = "group_chats_stream";
  var groupChatsMessagesStream = "group_chats_messages_stream";
}