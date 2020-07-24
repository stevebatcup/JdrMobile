import 'package:flutter/material.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:stacked/stacked.dart';

import 'lesson_detail_viewmodel.dart';

class LessonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonDetailViewModel>.reactive(
      viewModelBuilder: () => LessonDetailViewModel(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
        appBar: JdrAppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child: Text("Lesson detail")),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                model.loadLessonDetails('steve-test-1');
              },
              child: Text('Get lesson details'),
            ),
          ],
        )),
      ),
    );
  }
}
