import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Constants {
  static final String baseUrl = 'http://192.168.43.14:4000/api/';

  static String appName = "EuphoriaFX";

  static String postContent =
      "Post from the backend. Reliant Computing (Pty) Ltd. Continous coding excellence.";

  // Dark colors
  static Color lightPrimary = Color(0xfffcfcff);
  static Color lightAccent = Colors.green;
  static Color lightBG = Color(0xfffcfcff);

  // Light theme
  static Color darkPrimary = Colors.black;
  static Color darkAccent = Colors.green;
  static Color darkBG = Colors.black;

  // Badge Color
  static Color badgeColor = Colors.red;

  // Light theme
  static ThemeData lightTheme = ThemeData(
      backgroundColor: lightBG,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBG,
      appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
              title: TextStyle(
                  color: darkBG, fontSize: 18.0, fontWeight: FontWeight.w800),
              headline:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              body1: TextStyle(color: darkBG))));

  // Dark theme
  static ThemeData darkTheme = ThemeData(
      backgroundColor: darkBG,
      primaryColor: darkPrimary,
      accentColor: darkAccent,
      cursorColor: darkAccent,
      scaffoldBackgroundColor: darkBG,
      appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
              title: TextStyle(
                  color: lightBG, fontSize: 18.0, fontWeight: FontWeight.w800),
              headline:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              body1: TextStyle(color: Colors.white))));
}
