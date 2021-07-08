import 'package:flutter/material.dart';
import 'package:passman/themes/base_theme.dart';

class LightTheme extends BaseTheme {
  static final LightTheme _instance = LightTheme._();

  LightTheme._();

  factory LightTheme() => _instance;

  Map<String, Color> colors = {
    "accent": Color(0xFFFF4957),
    "primary": Color(0xFF5f6caf),
    "secondary": Color(0xFFff8364),
    "tertiary": Color(0xFFbae5e5),
    "fourtiary": Color(0xFF4A6572),
    "fivetiary": Color(0xFFffb677),
    "black": Color(0xFF2F2F2F),
    "white": Color(0xFFFFFFFF),
    "gray": Color(0xFFBDBFC7),
    "gray2": Color(0xFFD8D8D8),
    "gray3": Color(0xFFF0F0F0),
    "gray4": Color(0xFFF7F8FA),
    "borderColor": Color(0xFFff8364),
  };

  @override
  Color get primaryColor => Color(0xFF00796B);

  @override
  Color get accentColor => Color(0xFF00BCD4);

  @override
  Color get myColor => Color(0xFFe5e5e5);

  @override
  ThemeData get data => ThemeData.light().copyWith(
        primaryColor: primaryColor,
        accentColor: accentColor,
        canvasColor: Color(0xFFEEEEEE),
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 18,
            color: primaryColor,
            letterSpacing: 2,
            fontWeight: FontWeight.w900,
          ),
        ),
      );

  @override
  TextStyle get tsHistory => TextStyle(
        fontSize: 120,
        color: Color(0xFFBDBDBD).withOpacity(0.3),
        fontWeight: FontWeight.w700,
      );

  @override
  Color get colorScoreText => Color(0xFF3C786B);
}
