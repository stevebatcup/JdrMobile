import 'package:flutter/material.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';

class LessonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JdrAppBar(),
      body: Container(child: Text("Lesson detail")),
    );
  }
}
