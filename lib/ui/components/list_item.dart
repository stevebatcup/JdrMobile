import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/ui/components/author_avatar.dart';
import 'package:jdr/ui/components/list_item_image.dart';
import 'package:stacked_services/stacked_services.dart';

const TextStyle kMetaInfoStyle = TextStyle(
  fontSize: 14,
  color: Colors.blueGrey,
);

class ListItem extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final int id;
  final String path;
  final String title;
  final String image;
  final Widget metaInfo;
  final String authorAvatar;
  final String description;
  int screenDivisionFactor;

  ListItem({
    this.id,
    this.path,
    this.title,
    this.image,
    this.metaInfo,
    this.authorAvatar,
    this.description,
  }) {
    screenDivisionFactor = description != null ? 3 : 4;
    print(screenDivisionFactor);
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _navigationService.navigateTo(
          Routes.lessonDetailView,
          arguments: LessonDetailViewArguments(slug: path),
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListItemImage(
              id: id,
              image: image,
            ),
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      if (description != null)
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            description,
                            style: TextStyle(fontSize: 14.5),
                          ),
                        ),
                      Container(
                        child: id != -1 ? metaInfo : null,
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
