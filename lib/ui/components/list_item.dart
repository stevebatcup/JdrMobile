import 'package:flutter/material.dart';
import 'package:jdr/ui/components/author_avatar.dart';
import 'package:jdr/ui/components/list_item_image.dart';

const TextStyle kMetaInfoStyle = TextStyle(
  fontSize: 14,
  color: Colors.blueGrey,
);

class ListItem extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final Function onTap;
  final Widget metaInfo;
  final String authorAvatar;
  final String description;

  ListItem({
    this.id,
    this.title,
    this.image,
    this.onTap,
    this.metaInfo,
    this.authorAvatar,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
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
                        padding: EdgeInsets.only(top: 11.0),
                        child: id != -1
                            ? Text(
                                '$title',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.6,
                                  height: 1.4,
                                  color: Color(0XFF333333),
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
                            style: TextStyle(
                              fontSize: 14.5,
                              color: Color(0XFF333333),
                            ),
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
