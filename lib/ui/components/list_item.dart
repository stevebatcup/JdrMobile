import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/ui/components/author_avatar.dart';
import 'package:jdr/ui/components/list_item_image.dart';
import 'package:stacked_services/stacked_services.dart';

class ListItem extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final int id;
  final String path;
  final String title;
  final String image;
  final String authorName;
  final String authorAvatar;

  ListItem(
      {this.id,
      this.path,
      this.title,
      this.image,
      this.authorName,
      this.authorAvatar});

  @override
  Widget build(BuildContext context) {
    double boxHeight = MediaQuery.of(context).size.height / 4;
    double boxWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _navigationService.navigateTo(
          Routes.lessonDetailView,
          arguments: LessonDetailViewArguments(slug: path),
        );
      },
      child: Container(
        padding: EdgeInsets.zero,
        height: boxHeight * 1.52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListItemImage(
              boxHeight: boxHeight,
              boxWidth: boxWidth,
              id: id,
              image: image,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0, top: 12.0),
                    child: AuthorAvatar(
                      id: id,
                      avatar: authorAvatar,
                    ),
                  ),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 12.0),
                        child: id != -1
                            ? Text(
                                '$title',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.6,
                                  height: 1.4,
                                ),
                              )
                            : Container(
                                color: id != -1
                                    ? Colors.transparent
                                    : Colors.blueGrey,
                                height: 30,
                                width: boxWidth,
                              ),
                      ),
                      Container(
                        child: id != -1
                            ? Text(
                                authorName,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              )
                            : null,
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
