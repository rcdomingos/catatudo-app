import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressForm extends StatelessWidget {
  final TextEditingController ctlStreet;
  final TextEditingController ctlNumber;
  final TextEditingController ctlComplement;
  final TextEditingController ctlNeighborhood;
  final TextEditingController ctlCity;
  final TextEditingController ctlState;
  final TextEditingController ctlZipcode;
  final GlobalKey<FormState> formKey;

  AddAddressForm({
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
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          autovalidate: Provider.of<UserModel>(context).validate,
          child: Column(
            children: <Widget>[
              Text("Digite seus dados para cadastrar o endereço"),
              SizedBox(height: 30),
              TextFormField(
                controller: ctlStreet,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rua',
                ),
                validator: (value) {
                  return value.isEmpty
                      ? 'É necessário informar o nome da Rua'
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ctlNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ctlComplement,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Complemento',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ctlNeighborhood,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bairro',
                ),
                validator: (value) {
                  return value.isEmpty
                      ? 'É necessário informar o nome do Bairro'
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ctlCity,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cidade',
                ),
                validator: (value) {
                  return value.isEmpty
                      ? 'É necessário informar o nome do Cidade'
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ctlState,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UF',
                ),
                validator: (value) {
                  return value.isEmpty
                      ? 'É necessário informar o Sigla do estado (UF)'
                      : null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: ctlZipcode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CEP',
                ),
                validator: (value) {
                  return value.isEmpty ? 'É necessário informar o CEP' : null;
                },
              ),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
