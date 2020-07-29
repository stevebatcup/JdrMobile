import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdr/datamodels/downloadable.dart';
import 'package:jdr/ui/utils/color_scheme.dart';

class PdfListItem extends StatelessWidget {
  PdfListItem({
    Key key,
    this.downloadable,
  }) : super(key: key);

  final Downloadable downloadable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 2),
        child: Row(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.fileAlt,
              color: kPdfLinkColor,
              size: 18,
            ),
            SizedBox(width: 7),
            Text(
              downloadable.name,
              style: TextStyle(
                color: kPdfLinkColor,
                fontSize: 15,
                height: 1.65,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
