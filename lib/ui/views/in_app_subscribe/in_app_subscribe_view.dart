import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdr/ui/components/jdr_app_bar.dart';
import 'package:stacked/stacked.dart';

import 'in_app_subscribe_viewmodel.dart';

class InAppSubscribeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ViewModelBuilder<InAppSubscribeViewModel>.reactive(
      viewModelBuilder: () => InAppSubscribeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: JdrAppBar(showUserMenu: false),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit. Laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Subscribe now for \$25.00'),
                      color: Colors.green[600],
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text('OR',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: model.signOut,
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
