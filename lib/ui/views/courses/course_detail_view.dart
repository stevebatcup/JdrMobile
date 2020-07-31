import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/datamodels/course.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/ui/components/author_avatar.dart';
import 'package:jdr/ui/components/course_lesson_item.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:jdr/ui/components/list_item.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:stacked/stacked.dart';
import 'course_detail_viewmodel.dart';

const TextStyle kCourseDetailsTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: kPrimaryVariant,
);

class CourseDetailView extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();

  final String path;
  CourseDetailView({this.path});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CourseDetailsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) {
        if (_authService.currentUser != null) {
          model.loadCourseDetails(path);
        }
      },
      viewModelBuilder: () => locator<CourseDetailsViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: JdrAppBar(),
        body: FutureBuilder<Course>(
          future: model.courseFuture,
          builder: (context, AsyncSnapshot<Course> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              ); // add shimmer text
            }

            Course course = snapshot.data;
            return LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: viewportConstraints.maxHeight),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              Text(
                                course.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'by ${course.authorName}',
                                style: kMetaInfoStyle,
                              ),
                              SizedBox(height: 20),
                              Text(
                                course.description,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text('LESSONS IN THIS COURSE',
                                    style: kCourseDetailsTitleStyle),
                              ),
                              Column(
                                children: course.lessons
                                    .map((lesson) =>
                                        CourseLessonItem(lesson: lesson))
                                    .toList(),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text('COURSE AUTHOR',
                                    style: kCourseDetailsTitleStyle),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    height: 70,
                                    child: AuthorAvatar(
                                      id: 1,
                                      avatar: course.authorAvatar,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    course.authorName,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text('COURSE DETAILS',
                                    style: kCourseDetailsTitleStyle),
                              ),
                              Row(
                                children: <Widget>[
                                  Text('${course.lessonCount}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Text(' in this course'),
                                ],
                              ),
                              Divider(
                                color: Colors.black38,
                                thickness: 1.5,
                                height: 20.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Difficulty: '),
                                  Text(course.skillLevelList(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Divider(
                                color: Colors.black38,
                                thickness: 1.5,
                                height: 20.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Released on '),
                                  Text(
                                    course.publishedAt,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        )),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
