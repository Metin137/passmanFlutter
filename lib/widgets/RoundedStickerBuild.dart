import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passman/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';

class RoundedStickerBuilder extends StatelessWidget {
  const RoundedStickerBuilder({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? theme.fifth,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 45),
          child: Text(
            title,
            style: mainTextTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
