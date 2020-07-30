import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdr/datamodels/downloadable.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:jdr/ui/views/lessons/pdf_view.dart';

class PdfListItem extends StatelessWidget {
  PdfListItem({
    Key key,
    this.downloadable,
  }) : super(key: key);

  final Downloadable downloadable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PDFScreen(downloadable.url)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 4.0),
              child: Icon(
                FontAwesomeIcons.fileAlt,
                color: kPdfLinkColor,
                size: 18,
              ),
            ),
            SizedBox(width: 7),
            Flexible(
              child: Text(
                downloadable.name,
                style: TextStyle(
                  color: kPdfLinkColor,
                  fontSize: 15,
                  height: 1.65,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
