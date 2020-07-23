import 'package:flutter/material.dart';
import 'package:jdr/ui/components/user_menu.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:stacked/stacked.dart';

import 'lessons_viewmodel.dart';

class LessonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: EdgeInsets.only(),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                UserMenu(onSignOut: model.signOut),
              ],
            ),
          ),
          body: Center(
            child: RaisedButton(
              onPressed: () {
                model.getLessons();
              },
              child: Text('Get Lessons'),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LessonsViewModel(),
    );
  }
}
