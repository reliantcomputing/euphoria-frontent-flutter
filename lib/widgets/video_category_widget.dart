import 'package:flutter/material.dart';

class VideoCategoryScreen extends StatefulWidget {
  @override
  _VideoCategoryScreenState createState() => _VideoCategoryScreenState();
}

class _VideoCategoryScreenState extends State<VideoCategoryScreen> {

  List<String> _categories = ["Class Room", "Analysis"];
  String  _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          DropdownButton(
            value: _selectedCategory,
            onChanged: (newValue){
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: _categories.map((category){
              return DropdownMenuItem(
                child: Text(category),
                value: category,
              );
            }).toList(),
          ),
          _selectedCategory == "Class Room"?Text("Class Room"):Text("Analysis")
        ],
      ),
    );
  }
}
