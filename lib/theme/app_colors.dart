import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  final Color? defaultColor;
  final Color? secondary;
  final Color? background;
  final Color? textFieldBorder;
  final Color? appButtonBackground;
  final Color? appButtonTextColor;

  const AppColors({
    required this.defaultColor,
    required this.secondary,
    required this.background,
    required this.textFieldBorder,
    required this.appButtonBackground,
    required this.appButtonTextColor,
  });

  @override
  AppColors copyWith({
    Color? defaultColor,
    Color? secondary,
    Color? background,
    Color? textFieldBorder,
    Color? appButtonBackground,
    Color? appButtonTextColor,
  }) {
    return AppColors(
      defaultColor: defaultColor ?? this.defaultColor,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      textFieldBorder: textFieldBorder ?? this.textFieldBorder,
      appButtonBackground: appButtonBackground ?? this.appButtonBackground,
      appButtonTextColor: appButtonTextColor ?? this.appButtonTextColor,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      background: Color.lerp(background, other.background, t),
      textFieldBorder: Color.lerp(textFieldBorder, other.textFieldBorder, t),
      appButtonTextColor:
          Color.lerp(appButtonTextColor, other.appButtonBackground, t),
      appButtonBackground:
          Color.lerp(appButtonBackground, other.appButtonBackground, t),
    );
  }
}
