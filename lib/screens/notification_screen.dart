import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/notification_model.dart';
import 'package:euphoriafx/screens/packages_screen.dart';
import 'package:euphoriafx/widgets/notification_item_widget.dart';
import 'package:flutter/material.dart';

import 'package:euphoriafx/services/robot_notification_service.dart';
import 'package:euphoriafx/services/team_notification_service.dart';
import 'package:euphoriafx/services/other_notification_service.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:time_formatter/time_formatter.dart';

class NotificationScreen extends StatefulWidget {
  final PhoenixSocket socket =
      new PhoenixSocket("ws://192.168.43.14:4000/socket/websocket");

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  PhoenixChannel _robotChannel;
  PhoenixChannel _teamChannel;
  PhoenixChannel _otherChannel;

  List<NotificationModel> robotNotifs = [];
  List<NotificationModel> teamNotifs = [];
  List<NotificationModel> otherNotifs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
    _connectSocket();
  }

  _connectSocket() async {
    await widget.socket.connect();
    _otherChannel = widget.socket.channel("notifications:other:3");
    _otherChannel.on("new_other_notification", _otherNotification);
    _otherChannel.join();

    _teamChannel = widget.socket.channel("notifications:team:3");
    _teamChannel.on("new_team_notification", _teamNotification);
    _teamChannel.join();

    _robotChannel = widget.socket.channel("notifications:robot:3");
    _robotChannel.on("new_robot_notification", _robotNotification);
    _robotChannel.join();
  }

  _robotNotification(payload, _ref, _joinRef) {
    setState(() {
      robotNotifs.insert(
        robotNotifs.length,
        NotificationModel(
            notification: payload["robot_notification"]["notification"],
            userId: payload["robot_notification"]["user_id"],
            createdAt: payload["robot_notification"]["created_at"],
            isViewed: payload["robot_notification"]["is_viewed"],
            updatedAt: payload["robot_notification"]["updated_at"]),
      );
    });
  }

  _teamNotification(payload, _ref, _joinRef) {
    print(payload);
    setState(() {
      teamNotifs.insert(
        teamNotifs.length,
        NotificationModel(
            notification: payload["team_notification"]["notification"],
            userId: payload["team_notification"]["user_id"],
            createdAt: payload["team_notification"]["created_at"],
            isViewed: payload["team_notification"]["is_viewed"],
            updatedAt: payload["team_notification"]["updated_at"]),
      );
    });
  }

  _otherNotification(payload, _ref, _joinRef) {
    setState(() {
      otherNotifs.insert(
        otherNotifs.length,
        NotificationModel(
            notification: payload["other_notification"]["notification"],
            userId: payload["other_notification"]["user_id"],
            createdAt: payload["other_notification"]["created_at"],
            isViewed: payload["other_notification"]["is_viewed"],
            updatedAt: payload["other_notification"]["updated_at"]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var robotNotificationService = s1<RobotNotificationService>();
    var teamNotificationService = s1<TeamNotificationService>();
    var otherNotificationService = s1<OtherNotificationService>();

    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.person_outline,
          ),
          onPressed: () {},
        ),
        title: Text("Notifications"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
            ),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => PackagesScreen(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).textTheme.caption.color,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              text: "Robot",
            ),
            Tab(
              text: "Team",
            ),
            Tab(
              text: "Others",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FutureBuilder(
              future: robotNotificationService.getRobotNotifications(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NotificationModel>> snapshot) {
                if (snapshot.hasData) {
                  robotNotifs = snapshot.data;
                  if (robotNotifs.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.all(10.0),
                      separatorBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Divider(),
                          ),
                        );
                      },
                      itemCount: robotNotifs.length,
                      itemBuilder: (BuildContext context, int index) {
                        NotificationModel notif = robotNotifs[index];
                        return NotificationItemWidget(
                          type: "ROBOT",
                          notifId: notif.notificationId,
                          dp: "assets/logo.jpg",
                          notif: notif.notification,
                          time: notif.createdAt == null
                              ? formatTime(
                                  DateTime.now().millisecondsSinceEpoch)
                              : formatTime(
                                  notif.createdAt.millisecondsSinceEpoch),
                          viewed: notif.isViewed,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("Nothing to show"),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          FutureBuilder(
              future: teamNotificationService.getTeamNotifications(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NotificationModel>> snapshot) {
                if (snapshot.hasData) {
                  teamNotifs = snapshot.data;
                  if (teamNotifs.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.all(10.0),
                      separatorBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Divider(),
                          ),
                        );
                      },
                      itemCount: teamNotifs.length,
                      itemBuilder: (BuildContext context, int index) {
                        NotificationModel notif = teamNotifs[index];
                        return NotificationItemWidget(
                          type: "TEAM",
                          notifId: notif.notificationId,
                          dp: "assets/logo.jpg",
                          notif: notif.notification,
                          time: notif.createdAt == null
                              ? formatTime(
                                  DateTime.now().millisecondsSinceEpoch)
                              : formatTime(
                                  notif.createdAt.millisecondsSinceEpoch),
                          viewed: notif.isViewed,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("Nothing to show"),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          FutureBuilder(
              future: otherNotificationService.getOtherNotifications(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NotificationModel>> snapshot) {
                if (snapshot.hasData) {
                  otherNotifs = snapshot.data;
                  if (otherNotifs.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.all(10.0),
                      separatorBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Divider(),
                          ),
                        );
                      },
                      itemCount: otherNotifs.length,
                      itemBuilder: (BuildContext context, int index) {
                        NotificationModel notif = otherNotifs[index];
                        return NotificationItemWidget(
                          type: "OTHER",
                          notifId: notif.notificationId,
                          dp: "assets/cm0.jpeg",
                          notif: notif.notification,
                          time: notif.createdAt == null
                              ? formatTime(
                                  DateTime.now().millisecondsSinceEpoch)
                              : formatTime(
                                  notif.createdAt.millisecondsSinceEpoch),
                          viewed: notif.isViewed,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("Nothing to show"),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
