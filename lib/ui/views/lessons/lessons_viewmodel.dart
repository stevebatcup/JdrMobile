import 'package:jdr/app/locator.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';

import '../jdr_base_viewmodel.dart';

class LessonsViewModel extends JdrBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

  LessonsViewModel() {
    if (_authService.currentUser == null) signOut();
  }

  Future<List> getLessons() async {
    if (_authService.currentUser == null) {
      signOut();
      return null;
    }

    JdrNetworkingResponse result = await _networkService.getData(
      '/lessons',
      sessionCookie: _authService.sessionCookie,
    );

    print(result.jsonData);
    return null;
  }
}
