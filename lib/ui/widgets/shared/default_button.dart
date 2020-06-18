import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String texto;
  final Function onPressed;

  DefaultButton({this.texto, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(90),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
