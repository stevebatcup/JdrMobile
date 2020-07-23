import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_scheme.dart';

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 91,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 52,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.6,
    height: 0.5,
    shadows: [
      Shadow(
        color: Colors.white,
        blurRadius: 4.0,
      ),
    ],
    color: primaryColor,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    color: onBackgroundColor,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.1,
    color: onBackgroundColor,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
    backgroundColor: onErrorColor,
    color: Colors.white,
  ),
);
