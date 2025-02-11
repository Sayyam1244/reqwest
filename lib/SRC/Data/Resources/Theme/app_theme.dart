import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Data/Resources/Theme/light_theme.dart';

class CustomAppTheme with CustomLightTheme {
  CustomAppTheme._();

  static final CustomAppTheme instance = CustomAppTheme._();

  factory CustomAppTheme() => instance;

  ValueNotifier<ThemeMode> currentTheme = ValueNotifier(ThemeMode.light);
}
