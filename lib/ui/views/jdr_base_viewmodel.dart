import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JdrBaseViewModel extends BaseViewModel {
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();

  void signOut() async {
    bool result = await _authService.signOut();
    if (result) {
      _navigationService.replaceWith(Routes.loginView);
      notifyListeners();
    } else {
      print("Error logging out!");
    }
  }
}
