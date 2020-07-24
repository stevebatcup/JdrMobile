import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdr/ui/components/user_menu_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UserMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserMenuViewModel>.reactive(
      viewModelBuilder: () => UserMenuViewModel(),
      builder: (context, model, child) => PopupMenuButton(
        icon: Icon(
          FontAwesomeIcons.user,
        ),
        onSelected: model.onSelected,
        elevation: 2.2,
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem>[
            PopupMenuItem(
              value: null,
              child: Container(
                padding: const EdgeInsets.only(right: 15.0, left: 6.0),
                child: Text(
                  model.userName,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: UserMenuOptions.signOut,
              child: Container(
                padding: const EdgeInsets.only(right: 15.0, left: 6.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 14.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Sign out',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
