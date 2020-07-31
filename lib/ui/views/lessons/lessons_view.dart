import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/datamodels/category.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/components/category_list.dart';
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
      fireOnModelReadyOnce: false,
      onModelReady: (model) {
        if (_authService.currentUser != null) {
          model.loadLessons();
        }
      },
      builder: (context, model, child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: viewportConstraints.maxHeight),
              child: Column(
                children: <Widget>[
                  CategoryList(
                    onSelectCategory: (Category category) =>
                        model.selectCategory(category),
                  ),
                  model.loadingFirstPage == true
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: ListItem(id: -1),
                            ),
                          ),
                        )
                      : Expanded(
                          child: SmartRefresher(
                            controller: model.refreshController,
                            onRefresh: model.onRefresh,
                            child: model.lessons.length > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    controller: model.scrollController,
                                    itemCount: model.lessons.length,
                                    key: PageStorageKey(
                                        'lessons-list-storage-key'),
                                    itemBuilder: (context, index) {
                                      Lesson lesson = model.lessons[index];
                                      if (lesson.image != null) {
                                        return ListItem(
                                          id: lesson.id,
                                          title: lesson.title,
                                          image: lesson.image,
                                          onTap: () {
                                            model.onItemTap(lesson);
                                          },
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
                                  )
                                : Center(
                                    child: Text(
                                      "😢  No lessons found",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                ],
              ),
            );
          },
        );
      },
      viewModelBuilder: () => locator<LessonsViewModel>(),
    );
  }
}
