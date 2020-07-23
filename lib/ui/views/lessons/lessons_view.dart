import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'lessons_viewmodel.dart';

class LessonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
      ),
      viewModelBuilder: () => LessonsViewModel(),
    );
  }
}
