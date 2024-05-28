// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

//light mode
final primaryTheme = _getTheme(
  appColors: const AppColors(
    defaultColor: Color(0xFF2196F3),
    secondary: Color(0xFF000000),
    background: Colors.white,
    textFieldBorder: Colors.black,
    appButtonBackground: Colors.black,
    appButtonTextColor: Colors.white,
  ),
);

//dark mode
final secondaryTheme = _getTheme(
  appColors: const AppColors(
    defaultColor: Color(0xFFFF9800),
    secondary: Color(0xFFFFFFFF),
    background: Color(0xFF000000),
    textFieldBorder: Colors.white,
    appButtonBackground: Colors.white,
    appButtonTextColor: Colors.black,
  ),
);

ThemeData _getTheme({required AppColors appColors}) {
  return ThemeData(
    primarySwatch: Colors.cyan,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: appColors.defaultColor,
          secondary: appColors.secondary,
        ),
    scaffoldBackgroundColor: appColors.background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.defaultColor,
      selectionColor: appColors.defaultColor?.withOpacity(0.2),
      selectionHandleColor: appColors.defaultColor,
    ),
    extensions: [
      appColors,
      getAppTextStyles(defaultColor: appColors.defaultColor!),
    ],
  );
}
