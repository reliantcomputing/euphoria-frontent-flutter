import 'dart:math';

import 'package:euphoriafx/config/data.dart';
import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:euphoriafx/models/user_post_model.dart';
import 'package:euphoriafx/screens/packages_screen.dart';
import 'package:euphoriafx/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:euphoriafx/services/user_api_service.dart';
import 'package:time_formatter/time_formatter.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var r = new Random();

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    var userApiService = s1<UserApiService>();
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.person_outline,
          ),
          onPressed: () {},
        ),
        title: Text("People"),
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
              text: "Students",
            ),
            Tab(text: "Mentors")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FutureBuilder(
              future: userApiService.getUsersPost(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserPostModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.all(10),
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
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        UserPostModel user = snapshot.data[index];
                        if (user.typeId == 1) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListTile(
                              leading: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/cm4.jpeg"),
                                    radius: 25.0,
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 6.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      height: 11.0,
                                      width: 11.0,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(6.0)),
                                          height: 7.0,
                                          width: 6.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              contentPadding: EdgeInsets.all(0),
                              title: Text(user.username,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: Text("Just joined euphoriaFX"),
                              trailing: Text(
                                formatTime(
                                    DateTime.now().millisecondsSinceEpoch -
                                        r.nextInt(700000000)),
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(user: user)));
                              },
                            ),
                          );
                        }
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
              future: userApiService.getUsersPost(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserPostModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.all(10),
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
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        UserPostModel user = snapshot.data[index];
                        if (user.typeId == 2) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListTile(
                              leading: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/cm4.jpeg"),
                                    radius: 25.0,
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 6.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      height: 11.0,
                                      width: 11.0,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(6.0)),
                                          height: 7.0,
                                          width: 6.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              contentPadding: EdgeInsets.all(0),
                              title: Text(user.username,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: Text("Just joined euphoriaFX"),
                              trailing: Text(
                                formatTime(
                                    DateTime.now().millisecondsSinceEpoch -
                                        r.nextInt(700000000)),
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(user: user)));
                              },
                            ),
                          );
                        }
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
