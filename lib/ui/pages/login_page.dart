import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/viewModel/login_model.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/login_page/login_form.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
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
  GlobalKey<FormState> _formKey = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  get R => null;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>.value(
      value: LoginModel(
          authenticationService: Provider.of(context),
          userProfileModel: Provider.of<UserModel>(context)),
      child: Consumer<LoginModel>(
        child: LoginForm(
          ctlEmail: _ctlEmail,
          ctlPassword: _ctlPassword,
          formKey: _formKey,
        ),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Visibility(
            visible: !model.busy,
            child: Column(
              children: <Widget>[
                DefaultAppBar(
                  title: 'Entrar',
                  subTitle: 'Digite aqui seus dados para entrar',
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        child,
                        SizedBox(height: 20),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueci minha senha',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),

                        // SizedBox(height: 20),
                        // if (model.hasError)
                        //   Text(
                        //     model.error.description,
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(color: Colors.red, fontSize: 12),
                        //   ),
                      ],
                    ),
                  ),
                ),
                DefaultButton(
                  texto: 'Entrar',
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await model
                          .login(_ctlEmail.text, _ctlPassword.text)
                          .then((hasUser) {
                        if (hasUser) {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoute.HOME_PAGE);
                        } else {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(model.error.message),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(model.error.description),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Continuar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          // _scaffoldKey.currentState.showSnackBar(
                          //   SnackBar(
                          //     backgroundColor: Colors.red,
                          //     content: Row(
                          //       children: <Widget>[
                          //         Icon(Icons.notifications),
                          //         Text(model.error.description),
                          //       ],
                          //     ),
                          //     action: SnackBarAction(
                          //       label: 'Desfazer',
                          //       onPressed: () {
                          //         _scaffoldKey.currentState
                          //             .hideCurrentSnackBar();
                          //       },
                          //     ),
                          //     // the duration of your snack-bar
                          //     duration: Duration(milliseconds: 1500),
                          //   ),
                          // );
                        }
                      });
                    } else {
                      model.setValidate(true);
                    }
                  },
                ),
              ],
            ),
            replacement: Loading(texto: 'Aguarde, Carregando'),
          ),
        ),
      ),
    );
  }
}
