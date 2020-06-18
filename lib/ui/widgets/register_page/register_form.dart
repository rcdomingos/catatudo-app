import 'package:catatudo_app/core/viewModel/register_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController ctlNome;
  final TextEditingController ctlEmail;
  final TextEditingController ctlPassword;
  final TextEditingController ctlRepeatPass;
  final GlobalKey<FormState> formKey;

  RegisterForm(
      {this.ctlNome,
      this.ctlEmail,
      this.ctlPassword,
      this.ctlRepeatPass,
      this.formKey});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
          child: Form(
            autovalidate: Provider.of<RegisterModel>(context).validate,
            key: formKey,
            child: Column(
              children: <Widget>[
                Text("Digite seus dados para se cadastrar"),
                SizedBox(height: 20),
                TextFormField(
                  controller: ctlNome,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Fulano de Tal',
                    border: OutlineInputBorder(),
                    labelText: 'Nome Completo',
                  ),
                  validator: _validarNome,
                ),
                SizedBox(height: 20),
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
                  controller: ctlPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua Senha',
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: _validarSenha,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: ctlRepeatPass,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Confirme sua Senha',
                    border: OutlineInputBorder(),
                    labelText: 'Repita a Senha',
                  ),
                  validator: _validarSenhaIgual,
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///METODOS COM AS VALIDAÇÕES DO FORM
  ///validar o Nome
  String _validarNome(String value) {
    if (value.isEmpty) {
      return "Digite sue nome";
    }

    if (value.length < 2) {
      return "Seu nome deve ser maior ";
    }
  }

  ///validar o Email
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

  ///validar se as senhas conferem
  String _validarSenhaIgual(String value) {
    if (value.isEmpty) {
      return "Digite novamente a sua senha";
    }
    if (ctlPassword.text != value) {
      return "A senha não confere";
    }
  }
}
