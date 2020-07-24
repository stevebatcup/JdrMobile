import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:stacked_services/stacked_services.dart';
import '../jdr_base_viewmodel.dart';

@singleton
class CourseDetailsViewModel extends JdrBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void showCourseLesson() {
    _navigationService.navigateTo(Routes.lessonDetailView);
  }
}
