import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'themes_data_state.dart';

class ThemesDataCubit extends Cubit {
  ThemesDataCubit() : super(null) {
    darkThemes();
    List<Map<String, String>> deneme2 = [
      {"deneme: ": "deneme"}
    ];

    debugPrint("deneme22 $deneme2");
  }

  Map<String, String> deneme = {"deneme: ": "deneme"};

  Map<String, Color> colors = {};

  Map<String, Color> get getColors {
    return colors;
  }

  Map<String, Color> darkColors = {
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
    "textColor": Color(0xFFFFFFFF)
  };

  Map<String, Color> lightColors = {
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
    "textColor": Color(0xFF2F2F2F)
  };

  bool isDark = true;

  ThemeData get themeData => ThemeData(
      primaryColor: colors["borderColor"],
      accentColor: colors["borderColor"],
      backgroundColor: colors["primary"],
      scaffoldBackgroundColor: colors["tertiary"],
      textTheme: TextTheme(
        headline1: TextStyle(
            color: colors["textColor"],
            fontSize: 18.sp,
            fontWeight: FontWeight.w500),
        headline2: TextStyle(color: colors["textColor"], fontSize: 14.sp),
        bodyText1: TextStyle(color: colors["textColor"], fontSize: 14.sp),
        bodyText2: TextStyle(color: colors["textColor"], fontSize: 14.sp),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: Colors.green,
      ));

  void darkThemes() {
    emit(colors = darkColors);
  }

  void lightThemes() {
    emit(colors = lightColors);
  }

  void toggleThemes() {
    if (isDark) {
      lightThemes();
      isDark = false;
    } else {
      darkThemes();
      isDark = true;
    }
  }
}
