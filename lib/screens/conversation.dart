import 'package:bubble/bubble.dart';
import 'package:euphoriafx/config/data.dart';
import 'package:euphoriafx/models/single_chat_message.dart';
import 'package:euphoriafx/models/single_chat_model.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class Conversation extends StatefulWidget {
  final SingleChatModel singleChatModel;
  final UserModel user;
  final int currentUserId;

  final PhoenixSocket socket =
      new PhoenixSocket("ws://192.168.43.14:4000/socket/websocket");

  Conversation(
      {@required this.singleChatModel,
      @required this.user,
      @required this.currentUserId});
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  PhoenixChannel _channel;
  List<SingleChatMessageModel> messages = [];
  final TextEditingController _textController = TextEditingController();

  _connectSocket() async {
    await widget.socket.connect();
    _channel = widget.socket
        .channel("chats:" + widget.singleChatModel.chatId.toString());
    _channel.on("new_chat", _getMessage);
    _channel.join();
  }

  _getMessage(payload, _ref, _joinRef) {
    if (this.mounted) {


      setState(() {
        messages.insert(
            messages.length,
            SingleChatMessageModel(
                userId: payload["chat_message"]["user_id"],
                message: payload["chat_message"]["message"],
                seen: payload["chat_message"]["seen"],
                createdAt: payload["chat_message"]["created_at"]));
      });
    }
  }

  _sendMessage(message) {
    if (message.toString().isNotEmpty) {
      _channel.push(event: "new_chat", payload: {"chat_message": {
      "chat_id": widget.singleChatModel.chatId,
      "user_id": widget.currentUserId,
      "message": message
    }});
    } 
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: InkWell(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/cm${random.nextInt(10)}.jpeg",
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Text(
                      widget.user.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Online",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  SingleChatMessageModel msg =
                      messages.reversed.toList()[index];
                  return Bubble(
                    elevation: 0,
                    margin: widget.currentUserId == msg.userId
                        ? BubbleEdges.only(top: 10, left: 40)
                        : BubbleEdges.only(top: 10, right: 40),
                    alignment: widget.currentUserId == msg.userId
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    nip: widget.currentUserId == msg.userId
                        ? BubbleNip.rightTop
                        : BubbleNip.leftTop,
                    color: widget.currentUserId == msg.userId
                        ? Colors.green
                        : Colors.grey[200],
                    child: widget.currentUserId == msg.userId
                        ? Text(msg.message,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white))
                        : Text(msg.message, textAlign: TextAlign.right),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
//                height: 140,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(0.0, 1.5),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  maxHeight: 190,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.all(0),
                        title: TextField(
                          controller: _textController,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).textTheme.title.color,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "Write your message...",
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Theme.of(context).textTheme.title.color,
                            ),
                          ),
                          maxLines: null,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: (){
                            _sendMessage(_textController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      messages = widget.singleChatModel.messages;
    });
    _connectSocket();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
