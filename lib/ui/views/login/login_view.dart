import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jdr/ui/components/login_text_field.dart';
import 'package:jdr/ui/utils/color_scheme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0XFF08080A),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/justin-kit-login-zoomout.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: ModalProgressHUD(
                color: primaryColor,
                inAsyncCall: model.showSpinner,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Material(
                      color: Colors.transparent,
                      elevation: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xBB333333), Color(0x11333333)],
                          ),
                        ),
                        padding: EdgeInsets.only(
                            bottom: 10.0, top: 30, left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            LoginTextField(
                              hint: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validator: model.emailValidator,
                              onChanged: (value) {
                                model.submittedEmail = value;
                              },
                              formKey: model.formKey1,
                              focusNode: model.focusNode1,
                            ),
                            SizedBox(height: 10.0),
                            LoginTextField(
                              hint: 'Password',
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: model.passwordValidator,
                              onChanged: (value) {
                                model.submittedPassword = value;
                              },
                              formKey: model.formKey2,
                              focusNode: model.focusNode2,
                            ),
                            SizedBox(height: 4.0),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0),
                              onPressed: model.onSubmit,
                              child: Text(
                                "SIGN IN >",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1.0)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
