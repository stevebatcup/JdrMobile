import 'package:jdr/app/locator.dart';
import 'package:jdr/models/user.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class LessonsViewModel extends BaseViewModel {
  AuthService _authService = locator<AuthService>();

  String get title {
    User currentUser = _authService.currentUser;
    return 'Welcome ${currentUser.firstName}';
  }
}
