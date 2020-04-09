import 'package:euphoriafx/config/SizeConfig.dart';
import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:euphoriafx/models/user_post_model.dart';
import 'package:euphoriafx/services/auth_service.dart';
import 'package:euphoriafx/services/post_service.dart';
import 'package:euphoriafx/widgets/post_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_formatter/time_formatter.dart';

class ProfileScreen extends StatefulWidget {

  final UserPostModel user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var postService = s1<PostService>();
  var authService = s1<AuthService>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);

          return Scaffold(
            backgroundColor: Color(0xffF8F8FA),
            body: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  height: 40 * SizeConfig.heightMultiplier,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 10 * SizeConfig.heightMultiplier),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 11 * SizeConfig.heightMultiplier,
                              width: 22 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/profileimg.png"))),
                            ),
                            SizedBox(
                              width: 5 * SizeConfig.widthMultiplier,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                 widget.user.username,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 3 * SizeConfig.textMultiplier,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 1 * SizeConfig.heightMultiplier,
                                ),
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.comment,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 1.5 * SizeConfig.heightMultiplier,
                                        ),
                                        Text(
                                          widget.user.posts.length.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                1.5 * SizeConfig.textMultiplier,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 7 * SizeConfig.widthMultiplier,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.comment,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 2 * SizeConfig.widthMultiplier,
                                        ),
                                        Text(
                                          widget.user.posts.length.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                1.5 * SizeConfig.textMultiplier,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3 * SizeConfig.heightMultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Start Conversation",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          1.8 * SizeConfig.textMultiplier),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 35 * SizeConfig.heightMultiplier),
                  child: Container(
                  color: Color(0xffF8F8FA),

                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                          future: postService.getPosts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PostModel>> snapshot) {
                            List<PostModel> posts = [];

                            if (snapshot.hasData) {
                              posts = snapshot.data;
                              print(posts);
                            }

                            if (snapshot.hasData) {
                              return Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        PostModel post = snapshot.data[index];
                                        return PostItemWidget(
                                          postId: post.postId,
                                          img: "assets/cm9.jpeg",
                                          name: post.user.username,
                                          dp: "assets/cm8.jpeg",
                                          time: formatTime(post.createdAt
                                              .millisecondsSinceEpoch),
                                          likes: post.likes.length,
                                          comments: post.comments.length,
                                          postContent: post.content,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          })),
                )
              ],
            ),
          );
        });
      },
    );
  }

  _myAlbumCard(String asset1, String asset2, String asset3, String asset4,
      String more, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Container(
        height: 37 * SizeConfig.heightMultiplier,
        width: 60 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey, width: 0.2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      asset1,
                      height: 27 * SizeConfig.imageSizeMultiplier,
                      width: 27 * SizeConfig.imageSizeMultiplier,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      asset2,
                      height: 27 * SizeConfig.imageSizeMultiplier,
                      width: 27 * SizeConfig.imageSizeMultiplier,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier,
              ),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      asset3,
                      height: 27 * SizeConfig.imageSizeMultiplier,
                      width: 27 * SizeConfig.imageSizeMultiplier,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          asset4,
                          height: 27 * SizeConfig.imageSizeMultiplier,
                          width: 27 * SizeConfig.imageSizeMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: 27 * SizeConfig.imageSizeMultiplier,
                          width: 27 * SizeConfig.imageSizeMultiplier,
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: Text(
                              more,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.5 * SizeConfig.textMultiplier,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 2 * SizeConfig.heightMultiplier),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _favoriteCard(String s) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          s,
          height: 20 * SizeConfig.heightMultiplier,
          width: 70 * SizeConfig.widthMultiplier,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
