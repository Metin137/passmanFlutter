import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:provider/provider.dart';
import 'route/route.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemesProvider()),
      ],
      /* builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemesProvider>(context).data,
          home: Login(),
        );
      },*/
      builder: (context, themeData) {
        return ScreenUtilInit(builder: (_) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: context.watch<ThemesProvider>().getColors.primary,
            ),
          );

          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemesProvider>().themeData,
            onGenerateRoute: route.controller,
            initialRoute: route.LoginPage,
          );
        });
      },
    );
  }
}
