import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/screens/login_screen.dart';
import 'package:euphoriafx/services/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController username = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reset Password"),
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
                        SizedBox(height: 40),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  Map<String, dynamic> user = {
                                    "email": email.text,
                                  };

                                  userService.addUser(user);
                                }
                              },
                              child: Center(
                                child: Center(
                                  child: Text(
                                    "Reset Password",
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
                        
                      ],
                    );
                  })),
        ));
  }
}
