import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFF313341);
final Color onBackgroundColor = Color(0xFF565656);
final Color onErrorColor = Color(0xFFc13a3f);

final ColorScheme colorScheme = ColorScheme(
  primary: primaryColor,
  primaryVariant: Color(0xFF4A4D61),
  secondary: Color(0xFFdf004e),
  secondaryVariant: Color(0xFF930044),
  surface: Color(0xFFDCEBDC),
  background: Color(0xFFF2FDF7),
  error: Colors.transparent,
  onPrimary: Color(0xFFb0bec5),
  onSecondary: Color(0xFF899398),
  onSurface: Color(0xFF454545),
  onBackground: onBackgroundColor,
  onError: onErrorColor,
  brightness: Brightness.dark,
);
