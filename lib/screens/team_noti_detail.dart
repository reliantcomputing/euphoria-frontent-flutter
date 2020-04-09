import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/notification_model.dart';
import 'package:euphoriafx/services/team_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

class TeamNotificationDetailScreen extends StatefulWidget {
  final int notifId;

  TeamNotificationDetailScreen({@required this.notifId});

  @override
  _TeamNotificationDetailScreenState createState() =>
      _TeamNotificationDetailScreenState();
}

class _TeamNotificationDetailScreenState
    extends State<TeamNotificationDetailScreen> {
  var teamNotificationService = s1<TeamNotificationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Team Alert"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: teamNotificationService.getTeamNotification(widget.notifId),
          builder: (BuildContext context,
              AsyncSnapshot<NotificationModel> snapshot) {
            if (snapshot.hasData) {
              NotificationModel notif;

              if(snapshot.data != null){
                notif = snapshot.data;
              }
              if (notif != null) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(notif.notification,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                            formatTime(
                                notif.updatedAt.millisecondsSinceEpoch),
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text("Notification might be deleted."),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
