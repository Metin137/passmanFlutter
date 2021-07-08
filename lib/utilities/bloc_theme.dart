import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/dark_theme.dart';
import 'package:passman/themes/light_theme.dart';
import 'package:passman/themes/base_theme.dart';
import 'package:passman/themes/orange_theme.dart';
import 'package:passman/utilities/pref_utils.dart';

enum SupportedTheme { LIGHT, DARK, ORANGE, TOGGLE }

class BlocTheme extends Bloc<SupportedTheme, ThemeData> {
  static BaseTheme theme = LightTheme();

  BlocTheme() : super(null);

  static SystemUiOverlayStyle uiOverlayStyle() =>
      (theme.data.brightness == Brightness.light
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark)
          .copyWith(statusBarColor: Colors.transparent);

  @override
  ThemeData get initialState => theme.data;

  void toggleTheme() {
    if (theme == DarkTheme()) {
      print('object');
      theme = LightTheme();
    } else if (theme == LightTheme()) {
      theme = DarkTheme();
    }
  }

  @override
  Stream<ThemeData> mapEventToState(SupportedTheme event) async* {
    if (event == SupportedTheme.LIGHT) {
      theme = LightTheme();
    } else if (event == SupportedTheme.DARK) {
      theme = DarkTheme();
    } else if (event == SupportedTheme.ORANGE) {
      theme = OrangeTheme();
    } else if (event == SupportedTheme.TOGGLE) {
      toggleTheme();
    }
    int themeIndex = event == SupportedTheme.DARK
        ? 1
        : event == SupportedTheme.ORANGE
            ? 2
            : 0;
    await PrefUtils.saveTheme(themeIndex);
    yield theme.data;
  }
}
