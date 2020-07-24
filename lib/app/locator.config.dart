// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';
import '../services/third_party_services_module.dart';
import '../ui/views/courses/course_detail_viewmodel.dart';
import '../ui/views/courses/courses_viewmodel.dart';
import '../ui/views/lessons/lesson_detail_viewmodel.dart';
import '../ui/views/lessons/lessons_viewmodel.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);

  // Eager singletons must be registered in the right order
  gh.singleton<AuthService>(AuthService());
  gh.singleton<CourseDetailsViewModel>(CourseDetailsViewModel());
  gh.singleton<CoursesViewModel>(CoursesViewModel());
  gh.singleton<LessonDetailViewModel>(LessonDetailViewModel());
  gh.singleton<LessonsViewModel>(LessonsViewModel());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
