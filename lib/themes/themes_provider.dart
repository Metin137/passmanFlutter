import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemesProvider extends ChangeNotifier {
  Map<String, Color> colors = {
    "accent": Color(0xFFFF4957),
    "primary": Color(0xFF344955),
    "secondary": Color(0xFFF9AA33),
    "tertiary": Color(0xFF232F34),
    "fourtiary": Color(0xFF4A6572),
    "fivetiary": Color(0xFF063048),
    "black": Color(0xFF2F2F2F),
    "white": Color(0xFFFFFFFF),
    "gray": Color(0xFFBDBFC7),
    "gray2": Color(0xFFD8D8D8),
    "gray3": Color(0xFFF0F0F0),
    "gray4": Color(0xFFF7F8FA),
    "borderColor": Color(0xFFe5e5e5),
  };

  bool isDark = true;

  ThemeData get data => ThemeData.dark().copyWith(
        primaryColor: colors["primary"],
        accentColor: colors["accent"],
        canvasColor: Color(0xFFEEEEEE),
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 18,
            color: colors["primary"],
            letterSpacing: 2,
            fontWeight: FontWeight.w900,
          ),
        ),
      );

  void changeT() {
    if (isDark) {
      colors = {
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
      isDark = false;
    } else {
      colors = {
        "accent": Color(0xFFFF4957),
        "primary": Color(0xFF344955),
        "secondary": Color(0xFFF9AA33),
        "tertiary": Color(0xFF232F34),
        "fourtiary": Color(0xFF4A6572),
        "fivetiary": Color(0xFF063048),
        "black": Color(0xFF2F2F2F),
        "white": Color(0xFFFFFFFF),
        "gray": Color(0xFFBDBFC7),
        "gray2": Color(0xFFD8D8D8),
        "gray3": Color(0xFFF0F0F0),
        "gray4": Color(0xFFF7F8FA),
        "borderColor": Color(0xFFe5e5e5),
      };
      isDark = true;
    }

    notifyListeners();
  }
}
