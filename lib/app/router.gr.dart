// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/lessons/lessons_view.dart';
import '../ui/views/login/login_view.dart';

class Routes {
  static const String loginView = '/';
  static const String lessonsView = '/lessons-view';
  static const all = <String>{
    loginView,
    lessonsView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.lessonsView, page: LessonsView),
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
    LessonsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LessonsView(),
        settings: data,
      );
    },
  };
}
