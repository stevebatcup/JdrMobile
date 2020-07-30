import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: JdrAppBar(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          showUnselectedLabels: true,
          selectedFontSize: 15,
          selectedIconTheme: IconThemeData(size: 26),
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.yellow,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[200],
              title: Text(
                'Lessons',
                style: TextStyle(color: kPrimaryColor),
              ),
              icon: Icon(FontAwesomeIcons.drum, color: kPrimaryColor),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[200],
              title: Text(
                'Courses',
                style: TextStyle(color: kPrimaryColor),
              ),
              icon: Icon(FontAwesomeIcons.clipboardList, color: kPrimaryColor),
            ),
          ],
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: model.getView(),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
