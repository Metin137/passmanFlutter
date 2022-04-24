import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/utilities/responsiveLayout.dart';
import 'package:passman/themes/themes_provider.dart';
import 'package:passman/widgets/RoundedStickerBuild.dart';

class CardBuilder extends StatelessWidget {
  CardBuilder({
    Key? key,
    this.title = "Yeni Parola Oluştur",
    child,
    this.buttonText,
    this.stickerColor,
    this.onConfirm,
  })  : this.child = child ?? Container(),
        super(key: key);

  final String? title;
  final Widget? child;
  final String? buttonText;
  final Color? stickerColor;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.isMobile(context)
              ? 10.w
              : ResponsiveLayout.isTablet(context)
                  ? 100.w
                  : 120.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        RoundedStickerBuilder(
          title: title!,
          color: stickerColor,
        ),
        child!,
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              primary: theme.secondary,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(
                  color: theme.secondary,
                ),
              ),
            ),
            child: Text(
              buttonText ?? "Kaydet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
