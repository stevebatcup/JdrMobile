import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'lessons_viewmodel.dart';

class LessonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                model.loadLessons();
              },
              child: Text('Get Lessons'),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                model.showLesson();
              },
              child: Text('Show Lesson'),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<LessonsViewModel>(),
    );
  }
}
