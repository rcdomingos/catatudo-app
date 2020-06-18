import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image-mainScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Text(
                "Bem vindo ao CATATUDO",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                child: Text(
                  "Aqui você se cadastra e começa a utilizar o serviço de coleta reciclável",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            /// Botão de Cadastra-se
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                ),
              ),
              child: new RaisedButton(
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.REGISTER_PAGE);
                },
                child: Text(
                  "CADASTRE-SE",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /// Botão de Entrar
            Container(
              height: 100,
              width: double.infinity,
              color: Theme.of(context).buttonColor,
              child: new RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.LOGIN_PAGE);
                },
                child: Text(
                  "ENTRAR",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
