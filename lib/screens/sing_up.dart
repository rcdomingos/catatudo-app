import 'package:catatudo_app/controller/userController.dart';
import 'package:flutter/material.dart';

class SingUpScrenn extends StatefulWidget {
  @override
  _SingUpScrennState createState() => _SingUpScrennState();
}

class _SingUpScrennState extends State<SingUpScrenn> {
  GlobalKey<FormState> _fomrKey = new GlobalKey();
  var _crtNome = new TextEditingController();
  var _crtEmail = new TextEditingController();
  var _crtPassword = new TextEditingController();
  var _crtRepeatPass = new TextEditingController();
  bool _validate = false;
  Future<String> _futureUser;

  var controller = new UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body:
          (_futureUser == null) ? _telaCadastro() : buildContainer(_futureUser),
    );
  }

  /// METODO PARA ENVIAR O FORM PARA  API
  void _sendForm() {
    if (_fomrKey.currentState.validate()) {
      /// Sem erros na validação

      ///enviar a soliciação para API
      setState(() {
        _futureUser = controller.createUser(
            _crtNome.text, _crtEmail.text, _crtPassword.text);
      });
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }

  ///widget com o retorno do FutureBuider
  Widget buildContainer(Future<String> _futureUser) {
    return Container(
      child: FutureBuilder(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('${snapshot.data}'),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ///Widget com o Formulario de Cadastro
  Widget _formCadastro() {
    return Form(
      autovalidate: _validate,
      key: _fomrKey,
      child: Column(
        children: <Widget>[
          Text("Digite seus dados para se cadastrar"),
          SizedBox(height: 30),
          TextFormField(
            controller: _crtNome,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Fulano de Tal',
              border: OutlineInputBorder(),
              labelText: 'Nome Completo',
            ),
            validator: _validarNome,
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _crtEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'gerador@catatudo.com.br',
              border: OutlineInputBorder(),
              labelText: 'E-mail',
            ),
            validator: _validarEmail,
          ),
          SizedBox(height: 30),
          TextFormField(
            obscureText: true,
            controller: _crtPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              hintText: 'Digite sua Senha',
              border: OutlineInputBorder(),
              labelText: 'Senha',
            ),
            validator: _validarSenha,
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _crtRepeatPass,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              hintText: 'Confirme sua Senha',
              border: OutlineInputBorder(),
              labelText: 'Repita a Senha',
            ),
            validator: _validarSenhaIgual,
          ),
          Container(height: 220),
        ],
      ),
    );
  }

  ///WIDGET COM O FORMULARIO DE CADASTRO
  Widget _telaCadastro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
            child: _formCadastro(),
          )),
        ),
        SizedBox(
          height: 60,
          width: double.infinity,
          child: RaisedButton(
            color: Theme.of(context).buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(90),
              ),
            ),
            onPressed: _sendForm,
            child: Text(
              'Cadastrar',
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
    if (_crtPassword.text != value) {
      return "A senha não confere";
    }
  }
}
