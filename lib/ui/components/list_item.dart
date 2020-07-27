import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListItem extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final String authorName;
  final String authorAvatar;

  ListItem(
      {this.id, this.title, this.image, this.authorName, this.authorAvatar});

  @override
  Widget build(BuildContext context) {
    double boxHeight = MediaQuery.of(context).size.height / 4;
    double boxWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print(id);
      },
      child: Container(
        padding: EdgeInsets.zero,
        height: boxHeight * 1.52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: boxHeight,
                minHeight: boxHeight,
                minWidth: boxWidth,
              ),
              child: id != -1
                  ? CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.secondary),
                        )),
                        width: 50.0,
                        height: 50.0,
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: boxWidth,
                      color: Colors.grey,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0, top: 12.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: (id != -1 && authorAvatar != null)
                          ? NetworkImage(authorAvatar)
                          : null,
                      backgroundColor: Colors.blueGrey,
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
