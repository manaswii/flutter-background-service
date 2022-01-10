import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
      appBarTheme: const AppBarTheme(
          color: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          )),
    );
  }
}
