import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/comment_model.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:euphoriafx/services/post_service.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;

  PostDetailScreen({@required this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var postService = s1<PostService>();

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
          title: Text("Comments"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: postService.getPost(widget.postId),
            builder: (BuildContext context, AsyncSnapshot<PostModel> snapshot) {
              List<CommentModel> comments = [];
              if(snapshot.data != null){
                comments = snapshot.data.comments;
              }
              if (snapshot.hasData) {
                if (comments.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: comments.length,
                    itemBuilder: (BuildContext context, int index){
                      CommentModel comment = comments[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(backgroundImage: AssetImage("assets/cm9.jpeg"),),
                            SizedBox(width: 8,),
                            Expanded(child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.grey[100],
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Container(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(comment.user.username, style: TextStyle( fontWeight: FontWeight.bold), ),
                                  Text(comment.comment),
                                ],
                              )))),
                              
                          ],
                        ),
                      );
                    }
                    );
                } else {
                  return Center(
                    child: Text("No comments"),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
