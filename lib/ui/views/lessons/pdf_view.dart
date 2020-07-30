import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatelessWidget {
  final String pdfUrl;
  PDFScreen(this.pdfUrl);

  Future<File> createFileOfPdfUrl() async {
    final filename = pdfUrl.substring(pdfUrl.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(pdfUrl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: createFileOfPdfUrl(),
      builder: (context, AsyncSnapshot<File> snapshot) {
        if (snapshot.hasData) {
          return PDFViewerScaffold(
            appBar: JdrAppBar(),
            path: snapshot.data.path,
          );
        } else {
          return Scaffold(
            appBar: JdrAppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
