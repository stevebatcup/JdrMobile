import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/datamodels/category.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class LessonsViewModel extends BaseViewModel {
  bool loading = false;
  bool loadingFirstPage = true;
  int page = 1;
  int lessonsTotal;
  List<Lesson> lessons = [];
  Category selectedCategory;

  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  LessonsViewModel() {
    setupScrollEvent();
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    page = 1;
    lessons = [];
    loadingFirstPage = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));
    await loadLessons();
    refreshController.refreshCompleted();
  }

  void setupScrollEvent() {
    _scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;
      if ((_scrollController.position.pixels > triggerFetchMoreSize) &&
          !loading) {
        page++;
        loadLessons();
      }
    });
  }

  void onItemTap(Lesson lesson) {
    _navigationService.navigateTo(
      Routes.lessonDetailView,
      arguments: LessonDetailViewArguments(path: lesson.path),
    );
  }

  Future<void> selectCategory(Category category) async {
    page = 1;
    lessons = [];
    loadingFirstPage = true;
    selectedCategory = (selectedCategory != category) ? category : null;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1200));
    await loadLessons();
  }

  Future<void> loadLessons() async {
    loading = true;
    String url = '/lessons?page=$page';
    if (selectedCategory != null) {
      url += selectedCategory.isRoot
          ? '&root_category=${selectedCategory.id}'
          : '&root_category=${selectedCategory.rootCategoryId}&category=${selectedCategory.id}';
    }

    JdrNetworkingResponse result = await _networkService.getData(
      url,
      sessionCookie: _authService.sessionCookie,
    );

    if (result.jsonData['userAuthorisedForApp'] == false) {
      await _authService.signOut();
      _navigationService.replaceWith(Routes.loginView);
    }

    result.jsonData['items'].forEach((lessonData) {
      lessons.add(Lesson.basicFromJson(lessonData));
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
