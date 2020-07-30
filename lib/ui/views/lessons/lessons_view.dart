import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/components/list_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'lessons_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LessonsView extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) {
        if (_authService.currentUser != null) {
          model.loadLessons();
        }
      },
      builder: (context, model, child) {
        if (model.loadingFirstPage == true) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: ListItem(id: -1),
            ),
          );
        } else {
          return SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.onRefresh,
            child: ListView.builder(
              controller: model.scrollController,
              itemCount: model.lessons.length,
              key: PageStorageKey('lessons-list-storage-key'),
              itemBuilder: (context, index) {
                Lesson lesson = model.lessons[index];
                if (lesson.image != null) {
                  return ListItem(
                    id: lesson.id,
                    path: lesson.path,
                    title: lesson.title,
                    image: lesson.image,
                    metaInfo: Text(
                      lesson.authorName,
                      style: kMetaInfoStyle,
                    ),
                    authorAvatar: lesson.authorAvatar,
                  );
                } else {
                  return null;
                }
              },
            ),
          );
        }
      },
      viewModelBuilder: () => locator<LessonsViewModel>(),
    );
  }
}
