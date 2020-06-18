import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController ctlEmail;
  final TextEditingController ctlPassword;

  LoginForm({@required this.ctlEmail, this.ctlPassword});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Text("Digite aqui seus dados para entrar"),
              SizedBox(height: 40),
              Form(
                autovalidate: false,
                key: null,
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
                    ),
                  ],
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
  }
}
