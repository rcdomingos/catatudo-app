import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/viewModel/login_model.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/login_page/login_form.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _ctlEmail = TextEditingController();
  final TextEditingController _ctlPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>.value(
        value: LoginModel(
            authenticationService: Provider.of(context),
            userProfileModel: Provider.of<UserModel>(context)),
        child: Consumer<LoginModel>(
          child: LoginForm(ctlEmail: _ctlEmail, ctlPassword: _ctlPassword),
          builder: (context, model, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Entrar'),
            ),
            body: Visibility(
              visible: !model.busy,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          child,
                          SizedBox(height: 20),
                          FlatButton(
                            onPressed: () {},
                            child: Text('Esqueci a senha'),
                          )
                        ],
                      ),
                    ),
                  ),
                  DefaultButton(
                    texto: 'Entrar',
                    onPressed: () async {
                      var loginSuccess =
                          await model.login(_ctlEmail.text, _ctlPassword.text);
                      if (loginSuccess) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoute.HOME_PAGE);
                      }
                    },
                  ),
                ],
              ),
              replacement: Loading(texto: 'Aguarde, Carregando'),
            ),
          ),
        ));
  }
}
