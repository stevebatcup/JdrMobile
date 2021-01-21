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
      onModelReady: (model) {
        model.initInAppPurchases();
      },
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
                  if (model.loading) CircularProgressIndicator(),
                  if (model.isAvailable)
                    Column(
                      children: [
                        Text(
                          'You need to be a subscriber to access the content in this app. To become a subscriber, please click the button to purchase a one-month subscription. A subscription also unlocks all the on-site content available at www.jazzdrummersresource.com',
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
                            onPressed: () {
                              if (!model.purchasePending)
                                model.buySubscription();
                            },
                            elevation: model.purchasePending ? 0 : 3,
                            child: Text(model.purchasePending
                                ? 'Setting up subscription...'
                                : 'Subscribe now for \$25.00'),
                            color: model.purchasePending
                                ? Colors.green[100]
                                : Colors.green[600],
                            textColor: model.purchasePending
                                ? Colors.grey[400]
                                : Colors.white,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
