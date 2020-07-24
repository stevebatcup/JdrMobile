import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:jdr/ui/views/courses/course_detail_view.dart';
import 'package:stacked_services/stacked_services.dart';
import '../jdr_base_viewmodel.dart';

@singleton
class CoursesViewModel extends JdrBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

  Future<List> getCourses() async {
    if (_authService.currentUser == null) {
      signOut();
      return null;
    }

    JdrNetworkingResponse result = await _networkService.getData(
      '/courses',
      sessionCookie: _authService.sessionCookie,
    );

    print(result.jsonData);
    return null;
  }

  void showCourse() {
    _navigationService.navigateToView(CourseDetailView());
  }
}
