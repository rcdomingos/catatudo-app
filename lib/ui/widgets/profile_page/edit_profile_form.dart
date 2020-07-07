import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController ctlName;
  final TextEditingController ctlEmail;
  final TextEditingController ctlPhone;
  final GlobalKey<FormState> formKey;

  const EditProfileForm(
      {Key key, this.ctlName, this.ctlEmail, this.ctlPhone, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        autovalidate: true,
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: ctlName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
              validator: _validarNome,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlEmail,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: _validarEmail,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlPhone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telefone',
              ),
              validator: null,
            ),
          ],
        ),
      ),
    );
  }

  String _validarNome(String value) {
    if (value.isEmpty) {
      return "Digite sue nome";
    }

    if (value.length < 2) {
      return "Seu nome deve ser maior ";
    }
    return null;
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
}
