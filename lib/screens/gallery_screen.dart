import 'package:euphoriafx/config/data.dart';
import 'package:euphoriafx/screens/packages_screen.dart';
import 'package:euphoriafx/widgets/video_category_widget.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.person_outline,
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
        title: Text("Lesson Area"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket),
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
              text: "Videos",
            ),
            Tab(
              text: "Live Meeting",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          VideoCategoryScreen(),
          Center(
            child: isMeeting
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 100.0),
                      Text("Meeting in progress..."),
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                          "Join",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                : Text("No active meeting."),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
