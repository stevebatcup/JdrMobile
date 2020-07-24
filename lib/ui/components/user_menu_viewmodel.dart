import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum UserMenuOptions { signOut }

class UserMenuViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void signOut() async {
    bool result = await _authService.signOut();
    if (result) {
      _navigationService.replaceWith(Routes.loginView);
    } else {
      print("Error logging out!");
    }
  }

  String get userName => '${_authService.currentUser.fullName}';

  void onSelected(selection) {
    switch (selection) {
      case UserMenuOptions.signOut:
        signOut();
        break;
    }
  }
}
