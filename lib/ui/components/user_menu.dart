import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdr/app/locator.dart';
import 'package:jdr/services/auth_service.dart';

enum UserMenuOptions { signOut }

class UserMenu extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();
  final Function onSignOut;

  UserMenu({this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        FontAwesomeIcons.user,
      ),
      onSelected: (selection) {
        switch (selection) {
          case UserMenuOptions.signOut:
            onSignOut();
            break;
        }
      },
      elevation: 2.2,
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem>[
          PopupMenuItem(
            value: null,
            child: Container(
              padding: const EdgeInsets.only(right: 15.0, left: 6.0),
              child: Text(
                '${_authService.currentUser.fullName}',
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
    );
  }
}
