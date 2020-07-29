import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF313341);
const Color kOnBackgroundColor = Color(0xFF565656);
const Color kOnErrorColor = Color(0xFFc13a3f);
const Color kPdfLinkColor = Colors.blueGrey;

const ColorScheme colorScheme = ColorScheme(
  primary: kPrimaryColor,
  primaryVariant: Color(0xFF4A4D61),
  secondary: Color(0xFFdf004e),
  secondaryVariant: Color(0xFF930044),
  surface: Color(0xFFDCEBDC),
  background: Color(0xFFF2FDF7),
  error: Colors.transparent,
  onPrimary: Color(0xFFb0bec5),
  onSecondary: Color(0xFF899398),
  onSurface: Color(0xFF454545),
  onBackground: kOnBackgroundColor,
  onError: kOnErrorColor,
  brightness: Brightness.dark,
);
