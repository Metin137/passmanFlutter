import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passman/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:passman/cubit/themes_data_cubit.dart';
import 'package:passman/utilities/responsiveLayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passman/themes/themes_provider.dart';

class InputBuilder extends StatefulWidget {
  final String text;
  final double? borderRadius;
  final bool? multiline;
  final String? value;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  InputBuilder({
    Key? key,
    required this.text,
    this.borderRadius,
    this.multiline,
    this.value,
    this.onChanged,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  _InputBuilderState createState() => _InputBuilderState();
}

class _InputBuilderState extends State<InputBuilder> {
  @override
  Widget build(BuildContext context) {
    ThemeColors theme = context.watch<ThemesProvider>().getColors;
    TextTheme mainTextTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: widget.borderRadius != null ? Clip.hardEdge : Clip.none,
      height: widget.multiline != null ? 150 : 50,
      width: double.infinity,
      color: widget.borderRadius != null ? null : theme.secondary,
      decoration: widget.borderRadius != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              color: theme.secondary,
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            //color: Theme.of(context).colorScheme.accent,
            width: 150,
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: widget.multiline != null ? 20 : 0),
              child: Align(
                alignment: widget.multiline != null ? Alignment.topLeft : Alignment.centerLeft,
                child: Text(widget.text, style: mainTextTheme.bodyText2),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: theme.white,
              child: TextField(
                controller: widget.controller ?? null,
                focusNode: widget.focusNode ?? null,
                maxLines: widget.multiline != null ? null : 1,
                decoration: InputDecoration(
                  hintText: 'giriniz...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
