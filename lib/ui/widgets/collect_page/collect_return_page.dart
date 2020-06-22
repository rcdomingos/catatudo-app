import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:flutter/material.dart';

class ReturnCollectPage extends StatelessWidget {
  bool type;
  String message;
  ReturnCollectPage({this.message, this.type});

  @override
  Widget build(BuildContext context) {
    Icon _returnIcon = (type)
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
                      message,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            (type)
                ? DefaultButton(
                    texto: 'Ok',
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(AppRoute.HOME_PAGE);
                    })
                : DefaultButton(
                    texto: 'Voltar',
                    onPressed: () {
                      Navigator.of(context).pop();
                    })

            //                 Navigator.pop(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePage()),
            // );
          ],
        ),
      ),
    );
  }
}
