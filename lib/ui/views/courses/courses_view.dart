import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:stacked/stacked.dart';

import 'courses_viewmodel.dart';

class CoursesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoursesViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                model.getCourses();
              },
              child: Text('Get Courses'),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                model.showCourse();
              },
              child: Text('Show Course'),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<CoursesViewModel>(),
    );
  }
}
