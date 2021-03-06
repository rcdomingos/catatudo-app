import 'package:catatudo_app/core/viewModel/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController ctlEmail;
  final TextEditingController ctlPassword;
  final GlobalKey<FormState> formKey;

  LoginForm({@required this.ctlEmail, this.ctlPassword, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Consumer<LoginModel>(
                builder: (_, model, __) => Form(
                  autovalidate: model.validate,
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: ctlEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'gerador@catatudo.com.br',
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                        ),
                        validator: _validarEmail,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: ctlPassword,
                        decoration: const InputDecoration(
                          hintText: 'Digite sua Senha',
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                        ),
                        validator: _validarSenha,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///Metodo para validar a digitação do email
  String _validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe um email valido";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  ///Metodo para validar a digitação da senha
  String _validarSenha(String value) {
    if (value.isEmpty) {
      return "Digite sua senha";
    }
    return null;
  }
}
