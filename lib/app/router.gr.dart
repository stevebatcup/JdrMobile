// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/courses/course_detail_view.dart';
import '../ui/views/courses/courses_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/in_app_subscribe/in_app_subscribe_view.dart';
import '../ui/views/lessons/lesson_detail_view.dart';
import '../ui/views/lessons/lessons_view.dart';
import '../ui/views/login/login_view.dart';

class Routes {
  static const String homeView = '/';
  static const String loginView = '/login-view';
  static const String lessonsView = '/lessons-view';
  static const String lessonDetailView = '/lesson-detail-view';
  static const String coursesView = '/courses-view';
  static const String courseDetailView = '/course-detail-view';
  static const String inAppSubscribeView = '/in-app-subscribe-view';
  static const all = <String>{
    homeView,
    loginView,
    lessonsView,
    lessonDetailView,
    coursesView,
    courseDetailView,
    inAppSubscribeView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.lessonsView, page: LessonsView),
    RouteDef(Routes.lessonDetailView, page: LessonDetailView),
    RouteDef(Routes.coursesView, page: CoursesView),
    RouteDef(Routes.courseDetailView, page: CourseDetailView),
    RouteDef(Routes.inAppSubscribeView, page: InAppSubscribeView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    LessonsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LessonsView(),
        settings: data,
      );
    },
    LessonDetailView: (data) {
      var args = data.getArgs<LessonDetailViewArguments>(
        orElse: () => LessonDetailViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LessonDetailView(path: args.path),
        settings: data,
      );
    },
    CoursesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CoursesView(),
        settings: data,
      );
    },
    CourseDetailView: (data) {
      var args = data.getArgs<CourseDetailViewArguments>(
        orElse: () => CourseDetailViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CourseDetailView(path: args.path),
        settings: data,
      );
    },
    InAppSubscribeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => InAppSubscribeView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LessonDetailView arguments holder class
class LessonDetailViewArguments {
  final String path;
  LessonDetailViewArguments({this.path});
}

/// CourseDetailView arguments holder class
class CourseDetailViewArguments {
  final String path;
  CourseDetailViewArguments({this.path});
}
