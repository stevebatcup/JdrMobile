import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/components/jdr_snack_bar.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  String submittedEmail;
  String submittedPassword;

  LoginViewModel() {
    focusNode1.addListener(() {
      if (!focusNode1.hasFocus) {
        formKey1.currentState.validate();
      }
    });
    focusNode2.addListener(() {
      if (!focusNode2.hasFocus) {
        formKey2.currentState.validate();
      }
    });
  }

  final Function(String value) _emailValidator = (value) =>
      EmailValidator.validate(value) ? null : "Enter a valid email address";
  Function(String value) get emailValidator => _emailValidator;

  final Function(String value) _passwordValidator =
      (value) => value.length >= 6 ? null : "Should be at least 6 characters";
  Function(String value) get passwordValidator => _passwordValidator;

  void onSubmit() {
    if (formKey1.currentState.validate() && formKey2.currentState.validate()) {
      submitLoginDetailstoServer();
    }
  }

  Future<void> submitLoginDetailstoServer() async {
    AuthResult result = await _authService.signInWithEmail(
      email: submittedEmail,
      password: submittedPassword,
    );

    if (result.status == AuthResultStatus.success) {
      _navigationService.navigateTo(Routes.lessonsView);
    } else {
      JdrSnackBar.show(
        message: result.message,
        title: 'Error signing in',
        icon: Icons.error,
      );
    }
  }
}
