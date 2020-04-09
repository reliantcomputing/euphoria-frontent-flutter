import 'dart:math';
import 'package:euphoriafx/models/single_chat_message.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

class ChatBubble extends StatefulWidget {

  final SingleChatMessageModel message;
  final int currentUserId;

  ChatBubble({
    @required this.currentUserId,
    @required this.message});


  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}


class _ChatBubbleState extends State<ChatBubble> {


  List colors = Colors.primaries;
  static Random random = Random();
  int rNum = random.nextInt(18);



  @override
  Widget build(BuildContext context) {
    final bg = widget.message.userId == widget.currentUserId ?Theme.of(context).accentColor : Colors.grey[200];
    final align = widget.message.userId == widget.currentUserId ? CrossAxisAlignment.end: CrossAxisAlignment.start;
    final radius = widget.message.userId == widget.currentUserId
        ? BorderRadius.only(
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
      bottomRight: Radius.circular(10.0),
    )
        : BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth:  MediaQuery.of(context).size.width/1.3,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              widget.message.userId != widget.currentUserId ?Container(
                decoration: BoxDecoration(
                  color: widget.message.userId != widget.currentUserId 
                      ?Colors.grey[50]
                      :Colors.blue[50],
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                )
              ):SizedBox(width: 2),

              widget.message.userId != widget.currentUserId ?SizedBox(height: 5):SizedBox(),
              Padding(
                padding: EdgeInsets.all(5),
                child: widget.message.userId != widget.currentUserId 
                    ?Text(
                  widget.message.message,
                  style:  TextStyle(
                    color: widget.message.userId == widget.currentUserId 
                        ?Colors.white
                        :Colors.black,
                  ),
                )
                    :Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.message.message,
                    style:  TextStyle(
                      color: widget.message.userId == widget.currentUserId 
                          ?Colors.white
                          :Colors.black,
                    ),
                  ),
                )
              ),
            ],
          ),
        ),

        Padding(
          padding: widget.message.userId == widget.currentUserId 
              ? EdgeInsets.only(right: 10, bottom: 10.0,)
              :EdgeInsets.only(left: 10, bottom: 10.0,),
          child: Text(formatTime(widget.message.createdAt.millisecondsSinceEpoch),
            style: TextStyle(
              color: Colors.black,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}
