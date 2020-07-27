import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListItemImage extends StatelessWidget {
  const ListItemImage({
    Key key,
    @required this.boxHeight,
    @required this.boxWidth,
    @required this.id,
    @required this.image,
  }) : super(key: key);

  final double boxHeight;
  final double boxWidth;
  final int id;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
    );
  }
}
