// To parse this JSON data, do
//
//     final themeModel = themeModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

ThemeModel themeModelFromJson(String str) => ThemeModel.fromJson(json.decode(str));

String themeModelToJson(ThemeModel data) => json.encode(data.toJson());

Color jsonToColor(String arg) {
  var hexColor = arg.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  } else {
    return Color(0xFFFF);
  }
}

String colorToJson(Color color) {
  final regexp = RegExp(
    r'Color\(0xff(.*?)\)',
    caseSensitive: false,
    multiLine: true,
    unicode: true,
  );
  final match = regexp.firstMatch(color.toString());
  String matchedText = match!.group(1).toString();

  return '#$matchedText';
}

class ThemeModel {
  ThemeModel({
    required this.name,
    required this.colors,
  });

  String name;
  ThemeColors colors;

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        name: json["name"],
        colors: ThemeColors.fromJson(json["colors"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "colors": colors.toJson(),
      };
}

class ThemeColors {
  ThemeColors({
    required this.accent,
    required this.primary,
    required this.secondary,
    required this.thirth,
    required this.fourth,
    required this.fifth,
    required this.black,
    required this.white,
    required this.gray,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.borderColor,
    required this.textColor,
  });

  Color accent;
  Color primary;
  Color secondary;
  Color thirth;
  Color fourth;
  Color fifth;
  Color black;
  Color white;
  Color gray;
  Color gray2;
  Color gray3;
  Color gray4;
  Color borderColor;
  Color textColor;

  factory ThemeColors.fromJson(Map<String, dynamic> json) => ThemeColors(
        accent: jsonToColor(json["accent"]),
        primary: jsonToColor(json["primary"]),
        secondary: jsonToColor(json["secondary"]),
        thirth: jsonToColor(json["thirth"]),
        fourth: jsonToColor(json["fourth"]),
        fifth: jsonToColor(json["fifth"]),
        black: jsonToColor(json["black"]),
        white: jsonToColor(json["white"]),
        gray: jsonToColor(json["gray"]),
        gray2: jsonToColor(json["gray2"]),
        gray3: jsonToColor(json["gray3"]),
        gray4: jsonToColor(json["gray4"]),
        borderColor: jsonToColor(json["borderColor"]),
        textColor: jsonToColor(json["textColor"]),
      );

  Map<String, dynamic> toJson() => {
        "accent": colorToJson(accent),
        "primary": colorToJson(primary),
        "secondary": colorToJson(secondary),
        "thirth": colorToJson(thirth),
        "fourth": colorToJson(fourth),
        "fifth": colorToJson(fifth),
        "black": colorToJson(black),
        "white": colorToJson(white),
        "gray": colorToJson(gray),
        "gray2": colorToJson(gray2),
        "gray3": colorToJson(gray3),
        "gray4": colorToJson(gray4),
        "borderColor": colorToJson(borderColor),
        "textColor": colorToJson(textColor),
      };
}

ThemeModel darkColors = ThemeModel(
  name: "dark",
  colors: ThemeColors(
      accent: Color(0xFFFF4957),
      primary: Color(0xFF344955),
      secondary: Color(0xFFF9AA33),
      thirth: Color(0xFF232F34),
      fourth: Color(0xFF4A6572),
      fifth: Color(0xFF063048),
      black: Color(0xFF2F2F2F),
      white: Color(0xFFFFFFFF),
      gray: Color(0xFFBDBFC7),
      gray2: Color(0xFFD8D8D8),
      gray3: Color(0xFFF0F0F0),
      gray4: Color(0xFFF7F8FA),
      borderColor: Color(0xFFe5e5e5),
      textColor: Color(0xFFFFFFFF)),
);

ThemeModel lightColors = ThemeModel(
  name: "light",
  colors: ThemeColors(
    accent: Color(0xFFFF4957),
    primary: Color(0xFF5f6caf),
    secondary: Color(0xFFff8364),
    thirth: Color(0xFFbae5e5),
    fourth: Color(0xFF4A6572),
    fifth: Color(0xFFffb677),
    black: Color(0xFF2F2F2F),
    white: Color(0xFFFFFFFF),
    gray: Color(0xFFBDBFC7),
    gray2: Color(0xFFD8D8D8),
    gray3: Color(0xFFF0F0F0),
    gray4: Color(0xFFF7F8FA),
    borderColor: Color(0xFFff8364),
    textColor: Color(0xFF2F2F2F),
  ),
);

final defaultThemes = [darkColors, lightColors, darkColors, lightColors];
