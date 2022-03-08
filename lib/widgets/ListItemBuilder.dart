import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/CustomElevatedButton.dart';

class ListItemBuilder extends StatelessWidget {
  const ListItemBuilder({
    Key? key,
    required this.title,
    required this.icon,
    this.rightIcon = true,
    this.description = "",
    this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool? rightIcon;
  final String? description;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Map theme = context.watch<ThemesProvider>().getColors;
    //TextTheme mainTextTheme = Theme.of(context).textTheme;

    return CustomElevatedButton(
      onPressed: onPressed,
      color: theme["thirth"],
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Container(
        height: 90,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLeftIcon(theme),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: theme["white"],
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    buildTitle(theme),
                    if (rightIcon!) buildRightIcon(theme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRightIcon(Map<dynamic, dynamic> theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Icon(
        Entypo.chevron_small_right,
        color: theme["secondary"],
        size: 30.0,
      ),
    );
  }

  Expanded buildTitle(Map<dynamic, dynamic> theme) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: description != "" ? 20 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: description != ""
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme["textColor"],
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            if (description != "") ...[
              Text(
                description!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: theme["gray"],
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ]
          ],
        ),
      ),
    );
  }

  Padding buildLeftIcon(Map<dynamic, dynamic> theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Icon(
        icon,
        color: theme["secondary"],
        size: 30.0,
      ),
    );
  }
}
