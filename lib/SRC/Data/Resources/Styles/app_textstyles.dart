import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Data/Resources/Colors/light_colors_palate.dart';

class AppTextStyles {
//   Bold

  static TextStyle bold({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return TextStyle(
        fontSize: (fontSize ?? 32).sp,
        letterSpacing: letterSpacing ?? 0,
        color: color ?? LightColorsPalate.surfaceColor,
        fontFamily: 'Gilroy',
        fontWeight: fontWeight ?? FontWeight.w600);
  }

  // Semi bold
  static TextStyle semiBold({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return TextStyle(
        fontSize: (fontSize ?? 24).sp,
        letterSpacing: letterSpacing ?? 0,
        color: color ?? LightColorsPalate.surfaceColor,
        fontFamily: 'Gilroy',
        fontWeight: fontWeight ?? FontWeight.w500);
  }

  // Medium
  static TextStyle medium({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return TextStyle(
        fontSize: (fontSize ?? 16).sp,
        letterSpacing: letterSpacing ?? 0,
        color: color ?? LightColorsPalate.tertiaryColor,
        fontFamily: 'Gilroy',
        fontWeight: fontWeight ?? FontWeight.w500);
  }

  // Regular
  static TextStyle regular({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return TextStyle(
        fontSize: (fontSize ?? 10).sp,
        letterSpacing: letterSpacing ?? 0,
        color: color ?? LightColorsPalate.tertiaryColor,
        fontFamily: 'Gilroy',
        fontWeight: fontWeight ?? FontWeight.w400);
  }
}
