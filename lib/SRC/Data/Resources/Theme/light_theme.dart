import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Data/Resources/Colors/light_colors_palate.dart';
import 'package:reqwest/SRC/Data/Resources/Styles/app_textstyles.dart';

mixin CustomLightTheme {
  ThemeData lightTheme() => ThemeData(
      datePickerTheme: datePickerDialogTheme(),
      colorScheme: colorScheme,
      textTheme: textTheme(),
      buttonTheme: buttonTheme,
      appBarTheme: appBarTheme(),
      iconTheme: iconTheme,
      inputDecorationTheme: inputDecorationTheme(),
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      dialogTheme: dialogTheme(),
      radioTheme: radioTheme(),
      checkboxTheme: checkboxTheme(),
      dividerTheme: DividerThemeData(
        color: LightColorsPalate.surfaceColor.withOpacity(0.05),
      ),
      chipTheme: chipThemeData());

  // CheckBox Theme
  CheckboxThemeData checkboxTheme() => CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: const BorderSide(color: Colors.white),
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return LightColorsPalate.secondaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return LightColorsPalate.tertiaryColor;
          }
          return Colors.transparent;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green.withOpacity(0.5);
          }
          return Colors.red.withOpacity(0.5);
        }),
      );

  // Radio Button Theme
  RadioThemeData radioTheme() => RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return LightColorsPalate.secondaryColor;
          }
          return LightColorsPalate.tertiaryColor;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return LightColorsPalate.secondaryColor;
          }
          return LightColorsPalate.tertiaryColor;
        }),
      );

  // Color Scheme Theme
  static ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    onPrimary: LightColorsPalate.tertiaryColor,
    primary: LightColorsPalate.primaryColor,
    secondary: LightColorsPalate.secondaryColor,
    onError: LightColorsPalate.tertiaryColor,
    outline: LightColorsPalate.disableButtonColor.withOpacity(0.3),
    onInverseSurface: LightColorsPalate.disableButtonColor,
    onPrimaryContainer: LightColorsPalate.whiteColor,
    onSurfaceVariant: LightColorsPalate.sheetGred2,
    tertiary: LightColorsPalate.tertiaryColor,
    primaryContainer: LightColorsPalate.primaryColor,
    onSecondary: LightColorsPalate.tertiaryColor,
    error: LightColorsPalate.errorColor,
    onSecondaryContainer: LightColorsPalate.cardGred2,
    outlineVariant: LightColorsPalate.disableButtonColor.withOpacity(0.3),
    surface: LightColorsPalate.tertiaryColor,
    onSurface: LightColorsPalate.surfaceColor,
    background: LightColorsPalate.tertiaryColor,
    onBackground: LightColorsPalate.surfaceColor,
  );

  // Chip Theme
  static ChipThemeData chipThemeData() => ChipThemeData(
        backgroundColor: LightColorsPalate.secondaryColor,
        selectedColor: LightColorsPalate.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
        // selectedColor: DarkColorsPalate.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        brightness: Brightness.dark,
        labelStyle: AppTextStyles.regular(),
      );

  // Input Field Theme
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      hintStyle: AppTextStyles.regular(
          color: LightColorsPalate.surfaceColor.withOpacity(0.3),
          fontWeight: FontWeight.w400),
      filled: false,
      suffixIconColor: LightColorsPalate.tertiaryColor,
      prefixIconColor: LightColorsPalate.tertiaryColor,
      border: const UnderlineInputBorder(
        borderSide:
            BorderSide(width: 1.5, color: LightColorsPalate.secondaryColor),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide:
            BorderSide(width: 1.5, color: LightColorsPalate.secondaryColor),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: LightColorsPalate.secondaryColor,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: LightColorsPalate.primaryColor,
          width: 1.5,
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: LightColorsPalate.errorColor,
          width: 1.5,
        ),
      ),
    );
  }

  // bottom Navigation Bar Theme

  static BottomNavigationBarThemeData bottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    unselectedItemColor: LightColorsPalate.tertiaryColor,
    selectedItemColor: LightColorsPalate.secondaryColor,
  );

  // Dialog Theme
  static DialogTheme dialogTheme() {
    return DialogTheme(
      iconColor: LightColorsPalate.secondaryColor,
      backgroundColor: LightColorsPalate.primaryColor,
      alignment: Alignment.center,
      titleTextStyle: AppTextStyles.bold(),
      contentTextStyle: AppTextStyles.regular(fontSize: 16),
      shape: RoundedRectangleBorder(
        // side: const BorderSide(color: DarkColorsPalate.tertiaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static DatePickerThemeData datePickerDialogTheme() {
    return DatePickerThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            color: LightColorsPalate.tertiaryColor,
          ),
          labelStyle: TextStyle(
            color: LightColorsPalate.tertiaryColor,
          )),
      headerBackgroundColor: LightColorsPalate.primaryColor,
      headerForegroundColor: LightColorsPalate.tertiaryColor,
      cancelButtonStyle: const ButtonStyle(
          foregroundColor:
              MaterialStatePropertyAll(LightColorsPalate.tertiaryColor)),
      confirmButtonStyle: const ButtonStyle(
          foregroundColor:
              MaterialStatePropertyAll(LightColorsPalate.tertiaryColor)),
      backgroundColor: LightColorsPalate.primaryColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: LightColorsPalate.tertiaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  //Appbar Theme
  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: AppTextStyles.regular(),
    );
  }

  // Icon Theme
  static IconThemeData iconTheme = const IconThemeData(size: 24);

  //Button Theme
  static ButtonThemeData buttonTheme = const ButtonThemeData(
    buttonColor: LightColorsPalate.primaryColor,
    disabledColor: LightColorsPalate.disableButtonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(60)),
    ),
  );

  // TextStyle Theme
  static TextTheme textTheme() => TextTheme(
      //Bold Style
      headlineLarge: AppTextStyles.bold(
          fontSize: 32, color: LightColorsPalate.secondaryColor),
      headlineMedium: AppTextStyles.semiBold(),
      headlineSmall: AppTextStyles.bold(),

      //Medium Style
      titleLarge: AppTextStyles.medium(
          fontSize: 22, color: LightColorsPalate.surfaceColor),
      titleMedium: AppTextStyles.medium(
          fontSize: 20, color: LightColorsPalate.surfaceColor),
      titleSmall: AppTextStyles.medium(
          fontSize: 18, color: LightColorsPalate.surfaceColor),

      //Regular Style
      bodyLarge: AppTextStyles.regular(
          fontSize: 15, color: LightColorsPalate.surfaceColor),
      bodyMedium: AppTextStyles.regular(
          fontSize: 13, color: LightColorsPalate.surfaceColor.withOpacity(0.8)),
      bodySmall: AppTextStyles.regular(
          color: LightColorsPalate.surfaceColor, fontSize: 11));
}
