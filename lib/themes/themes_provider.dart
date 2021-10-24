import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:passman/helpers/shared_preferences_helper.dart';
import 'package:passman/extensions/color_extension.dart';

class ThemesProvider extends ChangeNotifier {
  SharedPreferencesHelper storageHelper = SharedPreferencesHelper();
  List<Map<String, dynamic>> allThemes = [];
  Map<String, Color> colors = {};

  Map<String, Color> get getColors {
    return colors;
  }

  bool isDark = true;

  ThemesProvider() {
    /*  darkThemes();
    getAllThemes(); */
    //setActiveTheme("dark");
  }

  Future<File> convertFile(String path) async {
    return File('$path');
  }

  Color toColor(String arg) {
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

  Future<ThemeData> getAllThemes() async {
    Directory? themesFileDirectory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getLibraryDirectory();

    File themesFile =
        await convertFile(join(themesFileDirectory!.path, "vawfd.txt"));

    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if ((await themesFile.exists())) {
      String response = await themesFile.readAsString();
      var allThemesDecode = jsonDecode(response);

      var allThemes2 = allThemesDecode.map((entry) {
        Map<String, Color> convertedColors = {};

        Map.from(entry["colors"]).keys.forEach((v) {
          convertedColors[v] = toColor(entry["colors"][v]);
        });

        return {"name": entry["name"], "colors": convertedColors};
      }).toList();

      allThemes = List<Map<String, dynamic>>.from(allThemes2);

      debugPrint("file: " + allThemes2.toString());

      getActiveTheme();
    } else {
      List defaultThemes = [darkColors, lightColors];
      await themesFile.create(recursive: true);
      debugPrint("filecreated: ");

      allThemes = List<Map<String, dynamic>>.from(defaultThemes);
      await themesFile.writeAsString(jsonEncode(themeToJson(defaultThemes)));
      setActiveTheme("dark");
    }
    return themeData;
  }

  getActiveTheme() async {
    String activeThemeKey =
        await storageHelper.getStorageItem(key: "activeTheme");

    var activeTheme =
        allThemes.firstWhere((element) => element["name"] == activeThemeKey);
    colors = Map<String, Color>.from(activeTheme["colors"]);
    debugPrint("activeTheme: " + activeTheme.toString());
  }

  setActiveTheme(String value) async {
    String activeThemeKey =
        await storageHelper.setStorageItem(key: "activeTheme", value: value);

    var activeTheme =
        allThemes.firstWhere((element) => element["name"] == value);
    colors = Map<String, Color>.from(activeTheme["colors"]);
    debugPrint("activeTheme: " + activeTheme.toString());
  }

  themeToJson(arg) {
    var allThemes2 = arg.map((entry) {
      Map<String, String> convertedColors = {};

      Map.from(entry["colors"]).keys.forEach((v) {
        final regexp = RegExp(
          r'Color\(0xff(.*?)\)',
          caseSensitive: false,
          multiLine: true,
          unicode: true,
        );
        final match = regexp.firstMatch(entry["colors"][v].toString());
        String matchedText = match!.group(1).toString();

        convertedColors[v] = '#$matchedText';
      });

      return {"name": entry["name"], "colors": convertedColors};
    }).toList();
    return allThemes2;
  }

  Map<String, dynamic> darkColors2 = {
    "name": "dark",
    "colors": {
      "accent": '#FF4957',
      "primary": '#344955',
      "secondary": '#F9AA33',
      "thirth": '#232F34',
      "fourth": '#4A6572',
      "fifth": '#063048',
      "black": '#2F2F2F',
      "white": '#FFFFFF',
      "gray": '#BDBFC7',
      "gray2": '#D8D8D8',
      "gray3": '#F0F0F0',
      "gray4": '#F7F8FA',
      "borderColor": '#e5e5e5',
      "textColor": '#FFFFFF'
    }
  };

  Map<String, dynamic> darkColors = {
    "name": "dark",
    "colors": {
      "accent": Color(0xFFFF4957),
      "primary": Color(0xFF344955),
      "secondary": Color(0xFFF9AA33),
      "thirth": Color(0xFF232F34),
      "fourth": Color(0xFF4A6572),
      "fifth": Color(0xFF063048),
      "black": Color(0xFF2F2F2F),
      "white": Color(0xFFFFFFFF),
      "gray": Color(0xFFBDBFC7),
      "gray2": Color(0xFFD8D8D8),
      "gray3": Color(0xFFF0F0F0),
      "gray4": Color(0xFFF7F8FA),
      "borderColor": Color(0xFFe5e5e5),
      "textColor": Color(0xFFFFFFFF)
    }
  };

  Map<String, dynamic> lightColors = {
    "name": "light",
    "colors": {
      "accent": Color(0xFFFF4957),
      "primary": Color(0xFF5f6caf),
      "secondary": Color(0xFFff8364),
      "thirth": Color(0xFFbae5e5),
      "fourth": Color(0xFF4A6572),
      "fifth": Color(0xFFffb677),
      "black": Color(0xFF2F2F2F),
      "white": Color(0xFFFFFFFF),
      "gray": Color(0xFFBDBFC7),
      "gray2": Color(0xFFD8D8D8),
      "gray3": Color(0xFFF0F0F0),
      "gray4": Color(0xFFF7F8FA),
      "borderColor": Color(0xFFff8364),
      "textColor": Color(0xFF2F2F2F)
    }
  };

  ThemeData get themeData => ThemeData(
        primaryColor: colors["borderColor"],
        accentColor: colors["borderColor"],
        backgroundColor: colors["primary"],
        scaffoldBackgroundColor: colors["thirth"],
        textTheme: TextTheme(
          headline1: TextStyle(
            color: colors["textColor"],
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(color: colors["textColor"], fontSize: 14.sp),
          bodyText1: TextStyle(color: colors["textColor"], fontSize: 14.sp),
          bodyText2: TextStyle(color: colors["textColor"], fontSize: 14.sp),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green,
        ),
      );

  darkThemes() {
    colors = darkColors["colors"];
    notifyListeners();
  }

  lightThemes() {
    colors = lightColors["colors"];
    notifyListeners();
  }

  toggleThemes() {
    if (isDark) {
      lightThemes();
      isDark = false;
    } else {
      darkThemes();
      isDark = true;
    }
  }
}
