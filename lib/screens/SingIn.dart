import 'package:flutter/material.dart';

class SingInScrenn extends StatefulWidget {
  @override
  _SingInScrennState createState() => _SingInScrennState();
}

class _SingInScrennState extends State<SingInScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Logim'),
      ),
      body: Container(
        child: Center(
          child: Text('Formulario de logim'),
        ),
      ),
    );
  }
}
