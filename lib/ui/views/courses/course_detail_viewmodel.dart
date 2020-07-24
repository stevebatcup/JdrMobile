import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class CourseDetailsViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

  Future<void> loadCourseDetails(int id) async {
    JdrNetworkingResponse result = await _networkService.getData(
      '/courses/$id',
      sessionCookie: _authService.sessionCookie,
    );

    if (result.jsonData['userAuthorisedForApp'] == false) {
      await _authService.signOut();
      _navigationService.navigateTo(Routes.loginView);
    }

    print(result.jsonData);
    return null;
  }

  void showCourseLesson() {
    _navigationService.navigateTo(Routes.lessonDetailView);
  }
}
