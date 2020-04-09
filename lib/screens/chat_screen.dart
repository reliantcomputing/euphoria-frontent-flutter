import 'package:euphoriafx/config/data.dart';
import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/single_chat_message.dart';
import 'package:euphoriafx/models/single_chat_model.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:euphoriafx/screens/packages_screen.dart';
import 'package:euphoriafx/services/auth_service.dart';
import 'package:euphoriafx/services/single_chat_service.dart';
import 'package:euphoriafx/widgets/person_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_formatter/time_formatter.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  var authService = s1<AuthService>();
  var singleChatService = s1<SingleChatService>();
  final storage = new FlutterSecureStorage();

  var token = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _setToken();
  }

  _setToken() async{
    var authToken = await storage.read(key: "token");
    setState(() {
      token = authToken;
    });
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
          onPressed: () {},
        ),
        title: Text("Chats"),
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
              icon: Icon(FontAwesomeIcons.envelope),
            ),
            Tab(icon: Icon(FontAwesomeIcons.users))
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FutureBuilder(
            future: singleChatService.getSingleChats(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SingleChatModel>> snapshot){
              List<SingleChatModel> chats = [];

              print("Toekn is here: " + token);

              if (snapshot.hasData) {
                print(snapshot.data);
                chats = snapshot.data;
              }
              if (snapshot.hasData) {
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
                  itemCount: chats.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data.isEmpty) {
                      return Center(
                        child: Text("Nothing to show"),
                      );
                    } else {
                      SingleChatModel singleChat = snapshot.data[index];
                      String lastMessage;
                      int timeMilliSeconds;

                      if (singleChat.messages.isNotEmpty) {
                        lastMessage = singleChat
                            .messages[singleChat.messages.length - 1].message;

                        timeMilliSeconds = singleChat
                            .messages[singleChat.messages.length - 1].createdAt.millisecondsSinceEpoch;
                      }else{
                        lastMessage = "";
                        timeMilliSeconds = singleChat.updatedAt.millisecondsSinceEpoch;
                      }

                      UserModel user;

                      singleChat.users.forEach((u) =>{
                        if (u.userId != authService.parseJwt(token)["sub"]) {
                          user = u
                        }
                      });

                      return PersonMessageWidget(
                          currentUserId: authService.parseJwt(token)["sub"],
                          singleChatModel: singleChat,
                          user: user,
                          dp: "assets/logo.jpg",
                          name: user.username,
                          isOnline: true,
                          counter: singleChat.messages.length,
                          msg: lastMessage,
                          time: formatTime(timeMilliSeconds));
                    }
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          ListView.separated(
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
            itemCount: groups.length,
            itemBuilder: (BuildContext context, int index) {
              Map chat = groups[index];
              return PersonMessageWidget(
                  dp: chat['dp'],
                  name: chat['name'],
                  isOnline: chat['isOnline'],
                  counter: chat['counter'],
                  msg: chat['msg'],
                  time: chat['time']);
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
