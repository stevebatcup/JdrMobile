import 'package:flutter/material.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';

class CourseDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JdrAppBar(),
      body: Center(child: Text("Course detail")),
    );
  }
}
