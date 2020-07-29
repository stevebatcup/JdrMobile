import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AuthorAvatar extends StatelessWidget {
  const AuthorAvatar({
    Key key,
    @required this.id,
    @required this.avatar,
  }) : super(key: key);

  final int id;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: (id != -1 && avatar != null)
          ? CachedNetworkImageProvider(avatar)
          : null,
      backgroundColor: id != -1 ? Colors.transparent : Colors.blueGrey,
    );
  }
}
