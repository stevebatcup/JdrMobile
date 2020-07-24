import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../jdr_base_viewmodel.dart';

@singleton
class LessonsViewModel extends JdrBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

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

  void showLesson() {
    _navigationService.navigateTo(Routes.lessonDetailView);
  }
}
