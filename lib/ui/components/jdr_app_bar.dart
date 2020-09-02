import 'package:flutter/material.dart';
import 'package:jdr/ui/components/user_menu.dart';
import 'package:jdr/ui/utils/color_scheme.dart';

class JdrAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool pageHasBottomSection;
  final bool showUserMenu;

  JdrAppBar({
    this.pageHasBottomSection = false,
    this.showUserMenu = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: pageHasBottomSection ? 0 : 4,
      backgroundColor: kPrimaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Hero(
            tag: 'logo',
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200),
              child: Container(
                padding: EdgeInsets.only(),
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),
          if (showUserMenu) UserMenu(),
        ],
      ),
    );
  }
}
