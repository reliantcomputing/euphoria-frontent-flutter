import 'package:euphoriafx/screens/other_noti_detail.dart';
import 'package:euphoriafx/screens/robot_noti_detail.dart';
import 'package:euphoriafx/screens/team_noti_detail.dart';
import 'package:flutter/material.dart';

class NotificationItemWidget extends StatefulWidget {
  final String dp;
  final String notif;
  final String time;
  final bool viewed;
  final int notifId;
  final String type;

  NotificationItemWidget(
      {Key key,
      @required this.notifId,
      @required this.dp,
      @required this.notif,
      @required this.time,
      @required this.viewed,
      @required this.type})
      : super(key: key);

  @override
  _NotificationItemWidgetState createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage("${widget.dp}"),
          radius: 25,
        ),
        contentPadding: EdgeInsets.all(0),
        title: Text("${widget.notif}",
            style: TextStyle(
                fontSize: 14,
                fontWeight:
                    widget.viewed ? FontWeight.normal : FontWeight.bold)),
        trailing: Text(
          "${widget.time}",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 11,
          ),
        ),
        onTap: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) {
                if(widget.type == "OTHER"){
                  return OtherNotificationDetailScreen(notifId: widget.notifId);
                }
                if(widget.type == "ROBOT"){
                  return RobotNotificationDetailScreen(notifId: widget.notifId,);
                }

                return TeamNotificationDetailScreen(notifId: widget.notifId);
              },
            ),
          );
        },
      ),
    );
  }
}
