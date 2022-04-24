import 'package:flutter/material.dart';

// Define Routes
import 'package:passman/screens/Login/LoginScreen.dart';
import 'package:passman/screens/PassList/PassListScreen.dart';
import 'package:passman/screens/Settings/SettingsScreen.dart';
import 'package:passman/screens/ThemeAndLanguage/ThemeAndLanguageScreen.dart';
import 'package:passman/screens/createPassword/createPassScreen.dart';

// Route Names
const String LoginPage = 'LoginPage';
const String List = 'List';
const String PassCreate = 'PassCreate';
const String Settings = 'Settings';
const String ThemeAndLAnguage = 'ThemeAndLAnguage';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments as Map<String, dynamic>?;
  //debugPrint("ara" + (args?["item"] ?? {}).toString());
  switch (settings.name) {
    case LoginPage:
      return MaterialPageRoute(builder: (context) => Login());
    case List:
      return MaterialPageRoute(builder: (context) => PassListScreen());
    case PassCreate:
      return MaterialPageRoute(
          builder: (context) => CreatePassScreen(
                screenType: args?["screenType"] ?? "create",
                item: args?["item"] ?? {},
              ));
    case Settings:
      return MaterialPageRoute(builder: (context) => SettingsScreen());
    case ThemeAndLAnguage:
      return MaterialPageRoute(builder: (context) => ThemeAndLanguageScreen());
    default:
      throw ('This route name does not exit');
  }
}
