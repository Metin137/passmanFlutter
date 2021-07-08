import 'package:flutter/material.dart';

abstract class BaseTheme {
  Map<String, Color> get colors;

  Color get primaryColor;

  Color get accentColor;

  Color get myColor;

  ThemeData get data;

  TextStyle get tsHistory;

  TextStyle get tsLoserScore => TextStyle(
        color: colorScoreText,
        fontSize: 26,
        fontWeight: FontWeight.w900,
      );

  TextStyle get tsWinnerScore => TextStyle(
        color: colorScoreText,
        fontSize: 36,
        fontWeight: FontWeight.w900,
      );

  Color get colorScoreText;
}
