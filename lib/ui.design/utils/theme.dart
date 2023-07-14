import 'package:flutter/material.dart';

class AppTheme {
  static var dark = ThemeData(
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff272727),
      ),
      backgroundColor: const Color(0xff272727),
      scaffoldBackgroundColor: const Color(0xff272727));

  static var light = ThemeData(
    canvasColor: Colors.white,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 251, 251, 255),
    ),
    backgroundColor: const Color.fromARGB(255, 251, 251, 255),
    scaffoldBackgroundColor: const Color.fromARGB(255, 251, 251, 255),
  );
}
