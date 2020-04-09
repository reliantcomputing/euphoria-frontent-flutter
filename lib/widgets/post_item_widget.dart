import 'package:euphoriafx/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';

class PostItemWidget extends StatefulWidget {
  final int postId;
  final String dp;
  final String name;
  final String time;
  final String img;
  final String postContent;
  final int likes;
  final int comments;

  PostItemWidget(
      {Key key,
      @required this.postId,
      @required this.dp,
      @required this.name,
      @required this.time,
      @required this.img,
      @required this.likes,
      @required this.postContent,
      @required this.comments});

  @override
  _PostItemWidgetState createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("${widget.dp}"),
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text("${widget.name}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                  "${widget.time}",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.postContent,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 7.0),
            InkWell(
              child: Image.asset(
                "${widget.img}",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>
                        PostDetailScreen(postId: widget.postId),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    "${widget.likes}",
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () {},
                  ),
                  Text(
                    "${widget.comments}",
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.comment,
                    ),
                    onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PostDetailScreen(postId: widget.postId),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 7.0),
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
