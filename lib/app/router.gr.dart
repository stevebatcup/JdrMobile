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
import '../ui/views/lessons/lesson_detail_view.dart';
import '../ui/views/lessons/lessons_view.dart';
import '../ui/views/login/login_view.dart';

class Routes {
  static const String loginView = '/';
  static const String homeView = '/home-view';
  static const String lessonsView = '/lessons-view';
  static const String lessonDetailView = '/lesson-detail-view';
  static const String coursesView = '/courses-view';
  static const String courseDetailView = '/course-detail-view';
  static const all = <String>{
    loginView,
    homeView,
    lessonsView,
    lessonDetailView,
    coursesView,
    courseDetailView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.lessonsView, page: LessonsView),
    RouteDef(Routes.lessonDetailView, page: LessonDetailView),
    RouteDef(Routes.coursesView, page: CoursesView),
    RouteDef(Routes.courseDetailView, page: CourseDetailView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => LessonDetailView(),
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => CourseDetailView(),
        settings: data,
      );
    },
  };
}
