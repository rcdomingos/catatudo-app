import 'package:flutter/material.dart';

class SingUpScrenn extends StatefulWidget {
  @override
  _SingUpScrennState createState() => _SingUpScrennState();
}

class _SingUpScrennState extends State<SingUpScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Cadastro'),
      ),
      body: Container(
        child: Center(
          child: Text('Formulario de Cadastro'),
        ),
      ),
    );
  }
}
