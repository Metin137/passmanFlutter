import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:provider/provider.dart';
import 'package:passman/themes/themes_provider.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.buttonText,
    this.color,
    this.child,
    this.padding,
    this.shape,
    this.onPressed,
  }) : super(key: key);
  final String? buttonText;
  final Color? color;
  final Widget? child;
  final EdgeInsets? padding;
  final RoundedRectangleBorder? shape;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Map theme = context.watch<ThemesProvider>().getColors;
    //TextTheme mainTextTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        primary: color ?? theme["secondary"],
        alignment: Alignment.center,
        elevation: 0,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(
                color: color ?? theme["secondary"],
              ),
            ),
      ),
      child: child ??
          Text(
            buttonText ?? "Kaydet",
            style: TextStyle(color: Colors.white),
          ),
    );
  }
}
