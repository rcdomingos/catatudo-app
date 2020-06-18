import 'package:flutter/material.dart';

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
      ),
    );
  }
}
