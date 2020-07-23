import 'package:flutter/material.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:jdr/ui/utils/text_theme.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'app/router.gr.dart';

void main() {
  setupLocator();
  runApp(JdrApp());
}

class JdrApp extends StatelessWidget {
  // This widget is the root of your application.
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
      initialRoute: Routes.loginView,
      onGenerateRoute: Router().onGenerateRoute,
    );
  }
}
