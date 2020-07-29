import 'package:flutter/material.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:jdr/ui/views/login/login_viewmodel.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class LoginTextField extends HookViewModelWidget<LoginViewModel> {
  LoginTextField({
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.formKey,
    this.focusNode,
  });

  final String label;
  final String hint;
  final Function(String value) validator;
  final Function(String value) onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final double borderWidth = 3.0;
  final double borderRadius = 13.0;

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    return Material(
      elevation: 15.0,
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      child: Form(
        key: formKey,
        child: TextFormField(
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 17.0,
              vertical: 10.0,
            ),
            labelStyle: TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white10, width: borderWidth),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.amberAccent, width: borderWidth),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onError,
                  width: borderWidth),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onError,
                  width: borderWidth),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            errorStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: kOnErrorColor,
              height: 0.9,
              shadows: [Shadow(blurRadius: 5, color: Colors.black26)],
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
