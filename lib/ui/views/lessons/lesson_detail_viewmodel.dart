import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class LessonDetailViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

  bool loading = true;
  Future<Lesson> lessonFuture;

  Future<void> loadLessonDetails(String path) async {
    JdrNetworkingResponse result = await _networkService.getData(
      path,
      sessionCookie: _authService.sessionCookie,
    );

    if (result.jsonData['userAuthorisedForApp'] == false) {
      await _authService.signOut();
      _navigationService.replaceWith(Routes.loginView);
    }

    Lesson lesson = Lesson.fullFromJson(result.jsonData);
    await lesson.videoReady;

    lessonFuture = Future<Lesson>.value(lesson);

    notifyListeners();
    return lessonFuture;
  }
}
