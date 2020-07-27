import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:jdr/ui/utils/text_theme.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/jdr_http_overrides.dart';
import 'app/locator.dart';
import 'app/router.gr.dart';

void main() {
  HttpOverrides.global = JdrHttpOverrides();
  setupLocator();
  AuthService _authService = locator<AuthService>();
  WidgetsFlutterBinding.ensureInitialized();
  _authService.loadCurrentUserDetails().then((status) {
    if (status == true) {
      runApp(JdrApp(intitialRoute: Routes.homeView));
    } else {
      runApp(JdrApp(intitialRoute: Routes.loginView));
    }
  });
}

class JdrApp extends StatelessWidget {
  final String intitialRoute;
  JdrApp({this.intitialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: intitialRoute,
      onGenerateRoute: Router().onGenerateRoute,
    );
  }
}
