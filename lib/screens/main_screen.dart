import 'package:badges/badges.dart';
import 'package:euphoriafx/models/notification_model.dart';
import 'package:euphoriafx/models/user_post_model.dart';
import 'package:euphoriafx/screens/chat_screen.dart';
import 'package:euphoriafx/screens/feed_screen.dart';
import 'package:euphoriafx/screens/gallery_screen.dart';
import 'package:euphoriafx/screens/notification_screen.dart';
import 'package:euphoriafx/screens/people_screen..dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class MainScreen extends StatefulWidget {
  final PhoenixSocket socket =
      new PhoenixSocket("ws://192.168.43.14:4000/socket/websocket");
  final UserPostModel user;

  MainScreen({this.user});
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PhoenixChannel _channel;
  PageController _pageController;

  int _page = 0;

  PhoenixChannel _robotChannel;
  PhoenixChannel _teamChannel;
  PhoenixChannel _otherChannel;

  List<NotificationModel> robotNotifs = [];
  List<NotificationModel> teamNotifs = [];
  List<NotificationModel> otherNotifs = [];

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
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          FeedScreen(),
          ChatScreen(),
          NotificationScreen(),
          PeopleScreen(),
          GalleryScreen()
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColor,
            primaryColor: Theme.of(context).accentColor,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey[500]))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.comment), title: Container(height: 0.0)),
            BottomNavigationBarItem(
                icon: Badge(
                  elevation: 0,
                  badgeContent: Text('3',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  child: Icon(FontAwesomeIcons.envelope),
                ),
                title: Container(height: 0.0)),
            BottomNavigationBarItem(
                icon: Badge(
                  elevation: 0,
                  badgeContent: Text('3',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  child: Icon(FontAwesomeIcons.bell),
                ),
                title: Container(height: 0.0)),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.users), title: Container(height: 0.0)),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.video), title: Container(height: 0.0)),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _page);
    _connectSocket();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
