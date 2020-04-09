import 'dart:io';

import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/screens/main_screen.dart';
import 'package:euphoriafx/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddPostScreen extends StatefulWidget {
  final File img;

  AddPostScreen({@required this.img});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController post = new TextEditingController();

  var postService = s1<PostService>();

  void _onLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 7),
                  Text("Creating post")
                ],
              ),
            ),
          );
        });

    Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => MainScreen(),
        ),
      );
    });
  }

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
          title: Text("Create Post"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.file(widget.img),
                        SizedBox(height: 7),
                        TextFormField(
                          controller: post,
                          maxLines: 3,
                          decoration:
                              InputDecoration(hintText: "Write a message..."),
                        ),
                        SizedBox(height: 10),
                        RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                          onPressed: () async {
                            var postJson = {"content": post.text, "user": "1"};

                            var res = await postService.addPost(postJson);

                            if (res.statusCode == 201) {
                              Alert(
                                      context: context,
                                      type: AlertType.success,
                                      title: "Success",
                                      desc: "Post created successfully.")
                                  .show();
                                  
                              
                            
                            } else {
                              Alert(
                                      context: context,
                                      type: AlertType.error,
                                      title: "Failed",
                                      desc: res.body)
                                  .show();
                            }
                          },
                          color: Colors.white,
                          textColor: Colors.green,
                          child: Text("Create Post".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  );
                })));
  }
}
