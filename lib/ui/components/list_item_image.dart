import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListItemImage extends StatelessWidget {
  const ListItemImage({
    Key key,
    @required this.id,
    @required this.image,
  }) : super(key: key);

  final int id;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: id != -1
          ? CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Container(color: Colors.grey),
    );
  }
}
