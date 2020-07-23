import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/components/jdr_snack_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  String submittedEmail;
  String submittedPassword;
  bool showSpinner = false;

  LoginViewModel() {
    if (_authService.currentUser != null) {
      _navigationService.replaceWith(Routes.lessonsView);
    } else {
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
  }

  final Function(String value) _emailValidator = (value) =>
      EmailValidator.validate(value) ? null : "Enter a valid email address";
  Function(String value) get emailValidator => _emailValidator;

  final Function(String value) _passwordValidator =
      (value) => value.length >= 6 ? null : "Should be at least 6 characters";
  Function(String value) get passwordValidator => _passwordValidator;

  void onSubmit() {
    FocusManager.instance.primaryFocus.unfocus();
    if (formKey1.currentState.validate() && formKey2.currentState.validate()) {
      submitLoginDetailstoServer();
    }
  }

  void startSpinner() {
    showSpinner = true;
    notifyListeners();
  }

  void stopSpinner() {
    showSpinner = false;
    notifyListeners();
  }

  Future<void> submitLoginDetailstoServer() async {
    startSpinner();
    AuthResult result = await _authService.signInWithEmail(
      email: submittedEmail,
      password: submittedPassword,
    );

    stopSpinner();
    if (result.status == AuthResultStatus.success) {
      _navigationService.replaceWith(Routes.lessonsView);
      _dialogService
          .showDialog(
            title: 'Welcome ${_authService.currentUser.firstName}',
            description: 'Thanks for logging in!',
          )
          .catchError((e) {});
    } else {
      JdrSnackBar.show(
        message: result.message,
        title: 'Error signing in',
        icon: Icons.error,
      );
    }
  }
}
