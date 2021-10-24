import 'package:flutter/cupertino.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/CustomElevatedButton.dart';
import 'package:provider/provider.dart';

class RoundedButtonBuilder extends StatelessWidget {
  const RoundedButtonBuilder({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Map theme = context.watch<ThemesProvider>().getColors;

    return CustomElevatedButton(
      onPressed: onPressed,
      color: theme["fourth"],
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 15,
        ),
        child: Icon(
          icon,
          color: theme["textColor"],
          size: 30.0,
        ),
      ),
    );
  }
}
