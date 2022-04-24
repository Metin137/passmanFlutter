import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'route/route.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: BlocBuilder<ThemesDataCubit, dynamic>(
        builder: (context, themeData) {
          return ScreenUtilInit(builder: (_) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: context.watch<ThemesDataCubit>().getColors["primary"],
            ));

            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: context.watch<ThemesDataCubit>().themeData,
              onGenerateRoute: route.controller,
              initialRoute: route.LoginPage,
            );
          });
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
