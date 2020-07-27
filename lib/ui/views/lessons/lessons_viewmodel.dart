import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class LessonsViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();
  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool loading = false;
  bool loadingFirstPage = true;
  int page = 1;
  int lessonsTotal;
  List<Lesson> lessons = [];

  LessonsViewModel() {
    setupScrollistener();
  }

  void onRefresh() async {
    print("onRefresh");
    lessons = [];
    loadingFirstPage = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1500));
    await loadLessons();
    refreshController.refreshCompleted();
  }

  void setupScrollistener() {
    scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * scrollController.position.maxScrollExtent;
      if ((scrollController.position.pixels > triggerFetchMoreSize) &&
          !loading) {
        page++;
        loadLessons();
      }
    });
  }

  Future<void> loadLessons() async {
    loading = true;
    JdrNetworkingResponse result = await _networkService.getData(
      '/lessons?page=$page',
      sessionCookie: _authService.sessionCookie,
    );

    print('/lessons?page=$page');

    if (result.jsonData['userAuthorisedForApp'] == false) {
      await _authService.signOut();
      _navigationService.navigateTo(Routes.loginView);
    }

    result.jsonData['items'].forEach((lessonData) {
      lessons.add(Lesson.fromJson(lessonData));
    });

    if (page == 1 && result.jsonData.containsKey('total')) {
      lessonsTotal = result.jsonData['total'];
      loadingFirstPage = false;
    }

    notifyListeners();
    loading = false;
  }

  void showLesson() {
    _navigationService.navigateTo(Routes.lessonDetailView);
  }
}
