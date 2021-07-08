import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/screens/Login/LoginScreen.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/utilities/bloc_theme.dart';
import 'package:passman/utilities/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemesProvider()),
        BlocProvider<BlocTheme>(
          create: (_) => BlocTheme(),
        ),
        BlocProvider<ThemesDataCubit>(
          create: (BuildContext context) => ThemesDataCubit(),
        ),
      ],
      /* builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemesProvider>(context).data,
          home: Login(),
        );
      },*/
      child: BlocBuilder<BlocTheme, ThemeData>(
        builder: (context, themeData) {
          Map<String, String> deneme = {"deneme: ": "deneme"};
          List<Map<String, String>> deneme2 = [
            {"deneme: ": "deneme"}
          ];

          debugPrint("deneme2 $deneme2");
          print(themeData);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemesDataCubit>(context).themeData,
            home: Login(),
          );
        },
      ),
    );
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocTheme>(
          create: (_) => BlocTheme(),
        ),
      ],
      child: BlocBuilder<BlocTheme, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: Login(),
          );
        },
      ),
    );
  }

*/