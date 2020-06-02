import 'package:catatudo_app/controller/userController.dart';
import 'package:catatudo_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SingInScrenn extends StatefulWidget {
  @override
  _SingInScrennState createState() => _SingInScrennState();
}

class _SingInScrennState extends State<SingInScrenn> {
  GlobalKey<FormState> _fomrKey = new GlobalKey();
  var _crtEmail = new TextEditingController();
  var _crtPassword = new TextEditingController();
  bool _validate = false;
  Future<String> _futureUser;
  var controller = new UserController();
  final _storage = FlutterSecureStorage();
  String jwt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Entrar'),
      ),
      body: (_futureUser == null) ? _formSingIn() : buildContainer(_futureUser),
    );
  }

  ///formulario para acessar
  Widget _formSingIn() {
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
                autovalidate: _validate,
                key: _fomrKey,
                child: Column(
                  children: <Widget>[
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
                      keyboardType: TextInputType.visiblePassword,
                      controller: _crtPassword,
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
            ],
          ),
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
              'Entrar',
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

  /// MEtodo para enviar o Formulario
  void _sendForm() {
    if (_fomrKey.currentState.validate()) {
      // Sem erros na validação
      ///enviar a soliciação para API
      setState(() {
        _futureUser = controller.userSingIn(_crtEmail.text, _crtPassword.text);
      });
    } else {
      // erro de validação
      print('ERRO');
      setState(() {
        _validate = true;
      });
    }
  }

  ///widget com o retorno do FutureBuider
  Widget buildContainer(Future<String> _futureUser) {
    return FutureBuilder(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //gravar no storage a key
          jwt = snapshot.data;
          return _loginSucess();
        } else if (snapshot.hasError) {
          //TODO: ajustar o retorno do erro
          return Container(
            child: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        } else {
          return _loginLoading();
        }
      },
    );
  }

  ///Carregando
  Widget _loginLoading() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
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
              onPressed: null,
              child: Text(
                'Aguarde',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Logim com sucesso
  Widget _loginSucess() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Tudo Certo!'),
                )
              ],
            ),
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
              onPressed: _completeLogin(),
              child: Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///REdirecionar para a Home
  _completeLogin() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen.fromBase64(jwt),
        ),
      );
    });
  }
}
