import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:flutter/material.dart';

class ReturnPage extends StatelessWidget {
  bool _type;
  String _message;

  @override
  Widget build(BuildContext context) {
    this._type = true;
    this._message = ModalRoute.of(context).settings.arguments;

    Icon _returnIcon = (_type)
        ? Icon(Icons.check_circle, color: Colors.green, size: 50)
        : Icon(Icons.error, color: Colors.red, size: 50);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _returnIcon,
                    SizedBox(height: 20),
                    Text(
                      _message,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            DefaultButton(
                texto: 'Continuar',
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoute.START_PAGE);
                })
          ],
        ),
      ),
    );
  }
}
