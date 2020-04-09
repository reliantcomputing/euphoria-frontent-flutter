import 'package:euphoriafx/models/single_chat_model.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:euphoriafx/screens/conversation.dart';
import 'package:flutter/material.dart';

class PersonMessageWidget extends StatefulWidget {
  final String dp;
  final String name;
  final String time;
  final String msg;
  final bool isOnline;
  final int counter;

  final SingleChatModel singleChatModel;
  final UserModel user;
  final int currentUserId;

  PersonMessageWidget(
      {Key key,
      @required this.currentUserId,
      @required this.singleChatModel,
      @required this.user,
      @required this.dp,
      @required this.name,
      @required this.time,
      @required this.msg,
      @required this.isOnline,
      @required this.counter})
      : super(key: key);

  @override
  _PersonMessageWidgetState createState() => _PersonMessageWidgetState();
}

class _PersonMessageWidgetState extends State<PersonMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0.0),
        leading: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage("${widget.dp}"),
              radius: 25.0,
            ),
            Positioned(
              bottom: 0.0,
              left: 6.0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0)),
                height: 11.0,
                width: 11.0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            widget.isOnline ? Colors.greenAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(6.0)),
                    height: 7.0,
                    width: 6.0,
                  ),
                ),
              ),
            )
          ],
        ),
        title: Text(
          "${widget.name}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${widget.msg}"),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "${widget.time}",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0),
            ),
            SizedBox(height: 5),
            widget.counter == 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6.0)),
                    constraints: BoxConstraints(minHeight: 11, minWidth: 11),
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.0, left: 5, right: 5),
                      child: Text(
                        "${widget.counter}",
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
          ],
        ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Conversation(
                  singleChatModel: widget.singleChatModel,
                  user: widget.user,
                  currentUserId: widget.currentUserId,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
