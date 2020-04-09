import 'dart:async';
import 'dart:convert';

import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/screens/login_screen.dart';
import 'package:euphoriafx/services/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

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
                  Text("Signing up")
                ],
              ),
            ),
          );
        });

    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  final TextEditingController username = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Username is required'),
    MinLengthValidator(8, errorText: 'Username must be at least 8 digits long')
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Enter a valid email"),
  ]);

  var userService = s1<UserApiService>();

  ProgressDialog pr;

  String error = "";

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: "Please wait...",
        borderRadius: 10,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          elevation: 1,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/logo.jpg"),
                          radius: 100,
                        ),
                        TextFormField(
                          controller: username,
                          validator: usernameValidator,
                          decoration: InputDecoration(
                              labelText: "USERNAME",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: email,
                          validator: emailValidator,
                          decoration: InputDecoration(
                              labelText: "EMAIL",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: password,
                          validator: passwordValidator,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "PASSWORD",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          controller: confirmPassword,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                              labelText: "CONFIRM PASSWORD",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(height: 6),
                        Text("$error", style: TextStyle(color: Colors.red)),
                        SizedBox(height: 40),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  Map<String, dynamic> user = {
                                    "user": {
                                      "username": username.text,
                                      "email": email.text,
                                      "password": password.text,
                                      "type_id": 1
                                      }
                                  };
                                  pr.show();
                                  var response =
                                      await userService.addUser(user);

                                  if (response.statusCode == 201) {
                                    pr.hide().whenComplete(() {
                                      Alert(
                                              context: context,
                                              type: AlertType.success,
                                              title: "Success",
                                              desc:
                                                  "The user was created. Log in now.")
                                          .show();

                                      Navigator.push<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              LoginScreen(),
                                        ),
                                      );
                                    });
                                  } else if (response.statusCode == 400) {
                                    var email = await json
                                        .decode(response.body)["email"];
                                    var username = await json
                                        .decode(response.body)["username"];

                                    if (email != null) {
                                      pr.hide().whenComplete(() {
                                        Alert(
                                                context: context,
                                                type: AlertType.success,
                                                title: "Success",
                                                desc: email)
                                            .show();
                                      });
                                    }

                                    if (username != null) {
                                      Alert(
                                              context: context,
                                              type: AlertType.success,
                                              title: "Success",
                                              desc: username)
                                          .show();
                                    }
                                  } else {
                                    pr.hide().whenComplete(() {
                                      Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: "Error",
                                              desc:
                                                  "An unknown error occurred, please try again. Report the error if it persist")
                                          .show();
                                    });
                                  }
                                }
                              },
                              child: Center(
                                child: Center(
                                  child: Text(
                                    "REGISTER",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) =>
                                        LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            SizedBox(height: 20)
                          ],
                        )
                      ],
                    );
                  })),
        ));
  }
}
