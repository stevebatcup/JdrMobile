import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/datamodels/course.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/components/list_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'courses_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoursesView extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoursesViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: false,
      onModelReady: (model) {
        if (_authService.currentUser != null) {
          model.loadCourses();
        }
      },
      builder: (context, model, child) {
        if (model.initialLoading == true) {
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
              itemCount: model.courses.length,
              key: PageStorageKey('courses-list-storage-key'),
              itemBuilder: (context, index) {
                Course course = model.courses[index];
                if (course.image != null) {
                  return ListItem(
                    id: course.id,
                    description: course.description,
                    title: '${course.title} course',
                    image: course.image,
                    onTap: () {
                      model.onTap(course);
                    },
                    metaInfo: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Row(
                        children: <Widget>[
                          Text(course.authorName, style: kMetaInfoStyle),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              Icons.fiber_manual_record,
                              color: Colors.blueGrey,
                              size: 10,
                            ),
                          ),
                          Text(course.lessonCount, style: kMetaInfoStyle),
                        ],
                      ),
                    ),
                    authorAvatar: course.authorAvatar,
                  );
                } else {
                  return null;
                }
              },
            ),
          );
        }
      },
      viewModelBuilder: () => locator<CoursesViewModel>(),
    );
  }
}
