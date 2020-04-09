import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:euphoriafx/screens/add_post.dart';
import 'package:euphoriafx/screens/packages_screen.dart';
import 'package:euphoriafx/services/auth_service.dart';
import 'package:euphoriafx/services/post_service.dart';
import 'package:euphoriafx/widgets/post_item_widget.dart';
import 'package:euphoriafx/widgets/trending_posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:image_picker/image_picker.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var postService = s1<PostService>();

  var authService = s1<AuthService>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => AddPostScreen(img: image),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.person_outline,
          ),
          onPressed: () {},
        ),
        title: Text("Feeds"),
        centerTitle: true,
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
      ),
      body: FutureBuilder(
          future: postService.getPosts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
            List<PostModel> posts = [];

            if (snapshot.hasData) {
              posts = snapshot.data;
              print(posts);
            }

            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Container(
                      height: 170,
                      child: TrendingPosts(
                          posts: postService.trendingPosts(posts))),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        PostModel post = snapshot.data[index];
                        return PostItemWidget(
                          postId: post.postId,
                          img: "assets/cm9.jpeg",
                          name: post.user.username,
                          dp: "assets/cm8.jpeg",
                          time:
                              formatTime(post.createdAt.millisecondsSinceEpoch),
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
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: getImage,
      ),
    );
  }
}
