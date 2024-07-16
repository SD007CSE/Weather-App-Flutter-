import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
      );

  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey.shade800,
      );
}
