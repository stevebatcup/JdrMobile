import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdr/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class JdrSnackBar {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final String title;
  final String message;
  final IconData icon;

  JdrSnackBar.show({this.title, this.message, this.icon}) {
    _snackbarService.showCustomSnackBar(
      message: message,
      title: title,
      shouldIconPulse: false,
      barBlur: 7.0,
      duration: const Duration(seconds: 3),
      backgroundColor: Color(0X99444444),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(16),
      dismissDirection: SnackDismissDirection.VERTICAL,
      forwardAnimationCurve: Curves.easeInCirc,
      reverseAnimationCurve: Curves.easeOutCirc,
      overlayColor: Colors.transparent,
      overlayBlur: 0,
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 15,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
