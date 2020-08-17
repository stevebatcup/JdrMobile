import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:stacked_services/stacked_services.dart';

class CourseLessonItem extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final Lesson lesson;

  CourseLessonItem({this.lesson});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigationService.navigateTo(
          Routes.lessonDetailView,
          arguments: LessonDetailViewArguments(path: lesson.path),
        );
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                lesson.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          width: 85,
                          child: AspectRatio(
                            aspectRatio: 3 / 2,
                            child: CachedNetworkImage(
                              imageUrl: lesson.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 85,
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: SizedBox(),
                        ),
                      ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      color: Color(0XFF333333),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black38,
              thickness: 1.5,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
