import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressForm extends StatelessWidget {
  final TextEditingController ctlStreet;
  final TextEditingController ctlNumber;
  final TextEditingController ctlComplement;
  final TextEditingController ctlNeighborhood;
  final TextEditingController ctlCity;
  final TextEditingController ctlState;
  final TextEditingController ctlZipcode;
  final GlobalKey<FormState> formKey;

  EditAddressForm({
    this.ctlStreet,
    this.ctlNumber,
    this.ctlComplement,
    this.ctlNeighborhood,
    this.ctlCity,
    this.ctlState,
    this.ctlZipcode,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        autovalidate: Provider.of<UserModel>(context).validate,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: ctlStreet,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rua',
              ),
              validator: null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número',
              ),
              validator: null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlComplement,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Complemento',
              ),
              validator: null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlNeighborhood,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bairro',
              ),
              validator: null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlCity,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cidade',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlState,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'UF',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ctlZipcode,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CEP',
              ),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
