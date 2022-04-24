import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/models/theme_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:passman/helpers/shared_preferences_helper.dart';
import 'package:passman/extensions/color_extension.dart';

class ThemesProvider extends ChangeNotifier {
  SharedPreferencesHelper storageHelper = SharedPreferencesHelper();
  List<ThemeModel> allThemes = defaultThemes;
  ThemeColors _colors = defaultThemes[0].colors;
  String activeThemeName = defaultThemes[0].name;

  ThemeColors get getColors {
    return _colors;
  }

  bool isDark = true;

  ThemesProvider() {
    getAllThemes();
    //setActiveTheme("dark");
  }

  Future<File> convertFile(String path) async {
    return File('$path');
  }

  Future<ThemeData> getAllThemes() async {
    Directory? themesFileDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getLibraryDirectory();

    File themesFile = await convertFile(join(themesFileDirectory!.path, "vawfd.txt"));

    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if ((await themesFile.exists())) {
      String response = await themesFile.readAsString();
      var allThemesDecode = jsonDecode(response);

      var allThemes2 = allThemesDecode.map((entry) => ThemeModel.fromJson(entry)).toList();
      allThemes = List<ThemeModel>.from(allThemes2);
      debugPrint("file: " + allThemes.toString());

      getActiveTheme();
    } else {
      //List defaultThemes = [darkColors, lightColors];
      await themesFile.create(recursive: true);
      debugPrint("filecreated: ");
      var themesToJson = allThemes.map((entry) => entry.toJson()).toList();
      List<Map<String, dynamic>> convertJson = List<Map<String, dynamic>>.from(themesToJson);
      await themesFile.writeAsString(jsonEncode(convertJson));
      //setActiveTheme(allThemes[0].name);
    }
    return themeData;
  }

  getActiveTheme() async {
    String activeThemeKey = await storageHelper.getStorageItem(key: "activeTheme");

    var activeTheme = allThemes.firstWhere((element) => element.name == activeThemeKey);
    _colors = activeTheme.colors;
    activeThemeName = activeTheme.name;
    notifyListeners();
    debugPrint("activeTheme: " + activeTheme.name);
  }

  setActiveTheme(String value) async {
    String activeThemeKey = await storageHelper.setStorageItem(key: "activeTheme", value: value);

    var activeTheme = allThemes.firstWhere((element) => element.name == value);
    _colors = activeTheme.colors;
    activeThemeName = activeTheme.name;
    notifyListeners();
    debugPrint("activeTheme: " + activeTheme.name);
  }

  /* Map<String, dynamic> darkColors2 = {
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
  }; */

  ThemeData get themeData => ThemeData(
        primaryColor: getColors.borderColor,
        accentColor: getColors.borderColor,
        backgroundColor: getColors.primary,
        scaffoldBackgroundColor: getColors.thirth,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: getColors.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(color: getColors.textColor, fontSize: 14.sp),
          bodyText1: TextStyle(color: getColors.textColor, fontSize: 14.sp),
          bodyText2: TextStyle(color: getColors.textColor, fontSize: 14.sp),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green,
        ),
      );

  darkThemes() {
    _colors = darkColors.colors;
    activeThemeName = darkColors.name;
    notifyListeners();
  }

  lightThemes() {
    _colors = lightColors.colors;
    activeThemeName = lightColors.name;
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
