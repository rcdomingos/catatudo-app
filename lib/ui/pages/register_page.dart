import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/return_arguments.dart';
import 'package:catatudo_app/core/viewModel/register_model.dart';
import 'package:catatudo_app/ui/widgets/register_page/register_form.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  var _ctlNome = new TextEditingController();
  var _ctlEmail = new TextEditingController();
  var _ctlPassword = new TextEditingController();
  var _ctlRepeatPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>.value(
      value: RegisterModel(
        api: Provider.of(context),
      ),
      child: Consumer<RegisterModel>(
        child: RegisterForm(
          ctlNome: this._ctlNome,
          ctlEmail: this._ctlEmail,
          ctlPassword: this._ctlPassword,
          ctlRepeatPass: this._ctlRepeatPass,
          formKey: this._formKey,
        ),
        builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Visibility(
              visible: !model.busy,
              child: Column(
                children: <Widget>[
                  DefaultAppBar(
                    title: 'Cadastro',
                    subTitle: 'Digite seus dados para se cadastrar',
                  ),
                  child,
                  DefaultButton(
                      texto: 'Cadastrar',
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var returnRegister = await model.register(
                              this._ctlNome.text,
                              this._ctlEmail.text,
                              this._ctlPassword.text);

                          Navigator.pushNamed(context, AppRoute.RETURN_PAGE,
                              arguments: ReturnScreenArguments(
                                  'START_PAGE', returnRegister));
                        } else {
                          model.setValidate(true);
                        }
                      }),
                ],
              ),
              replacement: Loading(
                texto: 'Realizando o cadastro...',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
