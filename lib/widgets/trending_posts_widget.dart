import 'package:euphoriafx/config/data.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:euphoriafx/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrendingPosts extends StatefulWidget {
  final List<PostModel> posts;

  TrendingPosts({@required this.posts});

  @override
  _TrendingPostsState createState() => _TrendingPostsState();
}

class _TrendingPostsState extends State<TrendingPosts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Trending",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          letterSpacing: 1.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 7.0),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.posts.length,
              itemBuilder: (BuildContext context, int index) {
                PostModel post = widget.posts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            PostDetailScreen(postId: post.postId),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage("assets/cm5.jpeg"),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
