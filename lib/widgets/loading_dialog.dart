import 'package:flutter/material.dart';

class LoadingDialong extends StatefulWidget {
  final String message;

  LoadingDialong({@required this.message});
  @override
  _LoadingDialongState createState() => _LoadingDialongState();
}

class _LoadingDialongState extends State<LoadingDialong> {
  @override
  Widget build(BuildContext context) {
    return Center(child: 
    Dialog(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
                  SizedBox(height: 7),
                  Text(widget.message)
        ],
      ),)
    ));
  }
}