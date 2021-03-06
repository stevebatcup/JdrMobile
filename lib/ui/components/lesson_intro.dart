import 'package:flutter/material.dart';
import 'package:jdr/datamodels/lesson.dart';
import 'package:jdr/ui/components/author_avatar.dart';

class LessonIntro extends StatelessWidget {
  const LessonIntro({
    Key key,
    @required this.lesson,
  }) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: AuthorAvatar(
              avatar: lesson.authorAvatar,
              id: 1,
            ),
          ),
        ),
        Flexible(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Text(
              lesson.excerpt,
              softWrap: true,
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Color(0XFF333333),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
