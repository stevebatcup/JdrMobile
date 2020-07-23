import 'package:auto_route/auto_route_annotations.dart';

import 'package:jdr/ui/views/lessons/lessons_view.dart';
import 'package:jdr/ui/views/login/login_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: LessonsView),
])
class $Router {}
