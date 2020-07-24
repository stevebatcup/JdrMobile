import 'package:auto_route/auto_route_annotations.dart';
import 'package:jdr/ui/views/courses/course_detail_view.dart';
import 'package:jdr/ui/views/courses/courses_view.dart';

import 'package:jdr/ui/views/home/home_view.dart';
import 'package:jdr/ui/views/lessons/lesson_detail_view.dart';
import 'package:jdr/ui/views/lessons/lessons_view.dart';
import 'package:jdr/ui/views/login/login_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: LessonsView),
  MaterialRoute(page: LessonDetailView),
  MaterialRoute(page: CoursesView),
  MaterialRoute(page: CourseDetailView),
])
class $Router {}
