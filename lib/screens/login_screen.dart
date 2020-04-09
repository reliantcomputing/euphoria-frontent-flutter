import 'dart:async';
import 'dart:convert';

import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/user_post_model.dart';
import 'package:euphoriafx/screens/feed_screen.dart';
import 'package:euphoriafx/screens/forgot_password.dart';
import 'package:euphoriafx/screens/main_screen.dart';
import 'package:euphoriafx/screens/signup_screen.dart';
import 'package:euphoriafx/services/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController username = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long')
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Enter a valid email"),
  ]);

  var userService = s1<UserApiService>();

  final storage = FlutterSecureStorage();

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);

    return Scaffold(
        appBar: AppBar(
          leading: Text(""),
          title: Text("Login"),
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
                          validator: usernameValidator,
                          controller: username,
                          decoration: InputDecoration(
                              labelText: "USERNAME",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: passwordValidator,
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              labelText: "PASSWORD",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green,
                            child: GestureDetector(
                              onTap: () async {
                                Map<String, dynamic> user = {
                                  "username": username.text,
                                  "password": password.text
                                };
                                pr.style(
                                    message: "Please wait...",
                                    borderRadius: 10,
                                    backgroundColor: Colors.white,
                                    progressWidget: CircularProgressIndicator(),
                                    progressTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400),
                                    messageTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w600));
                                pr.show();
                                var response = await userService.login(user);

                                var body = json.decode(response.body);

                                if (body["token"] == null) {
                                  pr.hide().whenComplete(() {
                                    Alert(
                                      context: context,
                                      type: AlertType.error,
                                      title: "Auth Failed",
                                      desc:
                                          "No account was found matching that username and password",
                                    ).show();
                                  });
                                } else {
                                  if(storage.read(key: "token") == null){
                                    storage.write(key: "token", value: body["token"]);
                                  }else{
                                    storage.delete(key: "token");
                                    storage.write(key: "token", value: body["token"]);
                                  }
                                  

                                  print("authenticated");

                                  pr.hide().whenComplete(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen(user: UserPostModel.fromJson(body["user"]))));
                                  });
                                }
                              },
                              child: Center(
                                child: Center(
                                  child: Text(
                                    "LOGIN",
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
                              "New to EuphoriaFX",
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) =>
                                        SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  })),
        ));
  }
}
