import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/notification_model.dart';
import 'package:euphoriafx/services/other_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

class OtherNotificationDetailScreen extends StatefulWidget {

  final int notifId;

  OtherNotificationDetailScreen({
    @required this.notifId
  });

  @override
  _OtherNotificationDetailScreenState createState() => _OtherNotificationDetailScreenState();
}

class _OtherNotificationDetailScreenState extends State<OtherNotificationDetailScreen> {

    var otherNotificationService = s1<OtherNotificationService>();

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
          future: otherNotificationService.getOtherNotification(widget.notifId),
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