import 'package:flutter/material.dart';
import 'package:passman/utilities/themes.dart';

extension CustomColorScheme on ColorScheme {
  Color get accent =>
      brightness == Brightness.dark ? Color(0xFFFF4957) : Color(0xFF000);
  Color get mprimary =>
      brightness == Brightness.dark ? Color(0xFF000) : Color(0xFFfff);
  Color get secondary =>
      brightness == Brightness.dark ? Color(0xFFF9AA33) : Color(0xFFff8364);
  Color get tertiary =>
      brightness == Brightness.dark ? Color(0xFF232F34) : Color(0xFFbae5e5);
  Color get fourtiary =>
      brightness == Brightness.dark ? Color(0xFF4A6572) : Color(0xFF4A6572);
  Color get fivetiary =>
      brightness == Brightness.dark ? Color(0xFF063048) : Color(0xFFffb677);
  Color get black =>
      brightness == Brightness.dark ? Color(0xFF2F2F2F) : Color(0xFF2F2F2F);
  Color get white =>
      brightness == Brightness.dark ? Color(0xFFFFFFFF) : Color(0xFFfff);
  Color get gray =>
      brightness == Brightness.dark ? Color(0xFFBDBFC7) : Color(0xFFBDBFC7);
  Color get gray2 =>
      brightness == Brightness.dark ? Color(0xFFD8D8D8) : Color(0xFFD8D8D8);
  Color get gray3 =>
      brightness == Brightness.dark ? Color(0xFFF0F0F0) : Color(0xFFF0F0F0);
  Color get gray4 =>
      brightness == Brightness.dark ? Color(0xFFF7F8FA) : Color(0xFFF7F8FA);
  Color get borderColor =>
      brightness == Brightness.dark ? Color(0xFFe5e5e5) : Color(0xFFff8364);
}
