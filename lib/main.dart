import 'package:euphoriafx/config/constants.dart';
import 'package:euphoriafx/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import "config/injector_container.dart" as ic;

void main() {
  ic.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: Constants.appName,
    home: SplashScreen(),
    theme: Constants.lightTheme,
  ));
}


