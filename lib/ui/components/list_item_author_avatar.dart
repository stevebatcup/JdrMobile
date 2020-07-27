import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListItemAuthorAvatar extends StatelessWidget {
  const ListItemAuthorAvatar({
    Key key,
    @required this.id,
    @required this.authorAvatar,
  }) : super(key: key);

  final int id;
  final String authorAvatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: (id != -1 && authorAvatar != null)
          ? CachedNetworkImageProvider(authorAvatar)
          : null,
      backgroundColor: id != -1 ? Colors.transparent : Colors.blueGrey,
    );
  }
}
