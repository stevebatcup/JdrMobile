import 'package:flutter/material.dart';
import 'package:jdr/ui/views/courses/courses_view.dart';
import 'package:jdr/ui/views/lessons/lessons_view.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends IndexTrackingViewModel {
  Widget getView() {
    switch (currentIndex) {
      case 0:
        return LessonsView();
      case 1:
        return CoursesView();
    }
    return null;
  }
}
