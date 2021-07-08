import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passman/utilities/customColorScheme.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isDarkTheme = true;
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Color(0xFF344955),
        accentColor: Color(0xFFFF4957),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.green),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green,
        ));
  }
}


/*
let themes = [
    {
        name: 'dark',
        theme: {
            accent: "#FF4957",
            primary: "#344955",
            secondary: "#F9AA33",
            tertiary: "#232F34",
            fourtiary: "#4A6572",
            fivetiary: "#063048",
            black: "#2F2F2F",
            white: "#FFFFFF",
            gray: "#BDBFC7",
            gray2: "#D8D8D8",
            gray3: "#F0F0F0",
            gray4: "#F7F8FA",
            grey: 'grey',
            borderColor: '#e5e5e5',
        }
    },
    {
        name: 'light',
        theme: {
            accent: "#000",
            primary: "#5f6caf",
            secondary: "#ff8364",
            tertiary: "#bae5e5",
            fourtiary: "#4A6572",
            fivetiary: "#ffb677",
            black: "#2F2F2F",
            white: "#fff",
            gray: "#BDBFC7",
            gray2: "#D8D8D8",
            gray3: "#F0F0F0",
            gray4: "#F7F8FA",
            grey: '#5f6caf',
            borderColor: '#ff8364',

        }
    }
]
*/