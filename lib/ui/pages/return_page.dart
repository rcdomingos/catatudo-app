import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/models/return_arguments.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:flutter/material.dart';

class ReturnPage extends StatelessWidget {
  // ResponseApi _responseApi = new ResponseApi();

  @override
  Widget build(BuildContext context) {
    // this._responseApi =
    //     ModalRoute.of(context).settings.arguments as ResponseApi;
    final ReturnScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    Icon _returnIcon = (args.response.code == 201)
        ? Icon(Icons.check_circle, color: Colors.green, size: 50)
        : Icon(Icons.error, color: Colors.red, size: 50);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _returnIcon,
                    SizedBox(height: 20.0),
                    Text(
                      args.response.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      args.response.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DefaultButton(
                texto: 'Continuar',
                onPressed: () {
                  if (args.pageBack == 'HOME_PAGE') {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(AppRoute.HOME_PAGE));
                  } else {
                    Navigator.of(context)
                        // .pushReplacementNamed(AppRoute.START_PAGE);
                        .popUntil(ModalRoute.withName(AppRoute.START_PAGE));
                  }
                })
          ],
        ),
      ),
    );
  }
}
