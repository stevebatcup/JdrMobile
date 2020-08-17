import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/datamodels/course.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class CoursesViewModel extends BaseViewModel {
  bool loading = false;
  bool initialLoading = true;
  List<Course> _courses = [];

  List<Course> get courses => _courses;

  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _courses = [];
    initialLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));
    await loadCourses();
    refreshController.refreshCompleted();
  }

  Future<void> loadCourses() async {
    loading = true;
    JdrNetworkingResponse result = await _networkService.getData(
      '/courses',
      sessionCookie: _authService.sessionCookie,
    );

    if (result.jsonData['userAuthorisedForApp'] == false) {
      await _authService.signOut();
      _navigationService.navigateTo(Routes.loginView);
    }

    result.jsonData['items'].forEach((coursesData) {
      courses.add(Course.fromJson(coursesData));
    });

    notifyListeners();
    initialLoading = false;
    loading = false;
  }

  void onTap(Course course) {
    _navigationService.navigateTo(
      Routes.courseDetailView,
      arguments: CourseDetailViewArguments(path: course.path),
    );
  }
}
