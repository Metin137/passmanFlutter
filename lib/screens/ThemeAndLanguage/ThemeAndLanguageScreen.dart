import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:passman/models/theme_model.dart';
import 'package:passman/widgets/CustomElevatedButton.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/CardBuilder.dart';
import 'package:passman/widgets/InputBuilder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/widgets/RoundedStickerBuild.dart';

class ThemeAndLanguageScreen extends StatefulWidget {
  const ThemeAndLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ThemeAndLanguageScreen> createState() => _ThemeAndLanguageScreenState();
}

class _ThemeAndLanguageScreenState extends State<ThemeAndLanguageScreen> {
  int selectedIndex = 0;

  initState() {
    super.initState();
    List<ThemeModel> allThemes = context.read<ThemesProvider>().allThemes;
    String activeThemeName = context.read<ThemesProvider>().activeTheme.name;
    int findIndex = allThemes.indexWhere((element) => element.name == activeThemeName);
    setState(() {
      selectedIndex = findIndex;
    });
  }

  onConfirm() async {
    List<ThemeModel> allThemes = context.read<ThemesProvider>().allThemes;
    ThemeModel activeTheme = allThemes[selectedIndex];
    await context.read<ThemesProvider>().setActiveTheme(activeTheme.name);
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;
    List<ThemeModel> allThemes = context.watch<ThemesProvider>().allThemes;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primary,
          title: Center(
            child: Text(
              'Tema ve Dil',
              style: mainTextTheme.headline1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardBuilder(
                  title: "Dil",
                  stickerColor: theme.secondary,
                  onConfirm: () => onConfirm(),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildButtonItem(
                              theme: theme,
                              title: "turkish",
                            ),
                            SizedBox(width: 15),
                            buildButtonItem(
                              theme: theme,
                              title: "english",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      RoundedStickerBuilder(
                        title: "Tema",
                        color: theme.secondary,
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: allThemes.length,
                            itemBuilder: (context, index) {
                              return buildButtonItem(
                                theme: theme,
                                title: allThemes[index].name,
                                index: index,
                                isActive: index == selectedIndex,
                              );
                            }),
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

  SizedBox buildButtonItem({required ThemeColors theme, String? title = "", IconData? icon, index = 0, isActive = false}) {
    if (isActive) {
      return SizedBox(
        width: 150,
        height: 150,
        child: CustomElevatedButton(
          color: theme.fifth,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, color: theme.secondary),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon ?? Icons.language,
                size: 30,
                color: theme.secondary,
              ),
              Text(title!),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 150,
        height: 150,
        child: CustomElevatedButton(
          onPressed: () async {
            setState(() {
              selectedIndex = index;
            });
          },
          color: theme.fourth,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon ?? Icons.language,
                size: 30,
                color: theme.secondary,
              ),
              Text(title!),
            ],
          ),
        ),
      );
    }
  }
}
