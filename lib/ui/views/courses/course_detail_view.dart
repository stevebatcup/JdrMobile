import 'package:flutter/material.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'course_detail_viewmodel.dart';

class CourseDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CourseDetailsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => locator<CourseDetailsViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: JdrAppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Course detail"),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                model.showCourseLesson();
              },
              child: Text('Show course lesson 1'),
            ),
          ],
        )),
      ),
    );
  }
}
