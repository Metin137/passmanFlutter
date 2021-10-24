import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/CardBuilder.dart';
import 'package:passman/widgets/InputBuilder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/widgets/RoundedStickerBuild.dart';

class ThemeAndLanguageScreen extends StatelessWidget {
  const ThemeAndLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme["primary"],
          title: Center(
            child: Text(
              'Parola Oluştur',
              style: mainTextTheme.headline1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardBuilder(
                  title: "Dil",
                  stickerColor: theme["secondary"],
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildActiveItem(
                              theme: theme,
                              title: "turkish",
                            ),
                            SizedBox(width: 15),
                            buildPassiveItem(
                              theme: theme,
                              title: "english",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      RoundedStickerBuilder(
                        title: "Tema",
                        color: theme["secondary"],
                      ),
                      SizedBox(height: 40),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildActiveItem(
                              theme: theme,
                              title: "dark",
                            ),
                            SizedBox(width: 15),
                            buildPassiveItem(
                              theme: theme,
                              title: "light",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildPassiveItem(
      {required Map<dynamic, dynamic> theme,
      String? title = "",
      IconData? icon}) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: theme["fourth"],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.language,
            size: 30,
            color: theme["secondary"],
          ),
          Text(title!),
        ],
      ),
    );
  }

  Container buildActiveItem(
      {required Map<dynamic, dynamic> theme,
      String? title = "",
      IconData? icon}) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: theme["secondary"],
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        color: theme["fifth"],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.language,
            size: 30,
            color: theme["secondary"],
          ),
          Text(title!),
        ],
      ),
    );
  }
}
