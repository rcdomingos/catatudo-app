import 'dart:async';

import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/profile_page/edit_address_form.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressPage extends StatefulWidget {
  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  var _ctlStreet = new TextEditingController();
  var _ctlNumber = new TextEditingController();
  var _ctlNeighborhood = new TextEditingController();
  var _ctlComplement = new TextEditingController();
  var _ctlCity = new TextEditingController();
  var _ctlState = new TextEditingController();
  var _ctlZipcode = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Address address;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);

    this.address = ModalRoute.of(context).settings.arguments as Address;

    _ctlStreet.text = address.street;
    _ctlNumber.text = address.number;
    _ctlNeighborhood.text = address.neighborhood;
    _ctlComplement.text = address.complement;
    _ctlCity.text = address.city;
    _ctlState.text = address.state;
    _ctlZipcode.text = address.zipCode;

    // print(widget.address.toJson());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Editar Endereço'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              iconSize: 30,
              onPressed: () async {
                await userModel.deleteUserAddress(address).then((deleted) {
                  if (deleted) {
                    Navigator.pop(context);
                  } else {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(userModel.error.description),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: 'Desfazer',
                          onPressed: () {
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  }
                });
              }),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Visibility(
          visible: !userModel.busy,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: EditAddressForm(
                    formKey: this._formKey,
                    ctlStreet: this._ctlStreet,
                    ctlNumber: this._ctlNumber,
                    ctlNeighborhood: this._ctlNeighborhood,
                    ctlComplement: this._ctlComplement,
                    ctlCity: this._ctlCity,
                    ctlState: this._ctlState,
                    ctlZipcode: this._ctlZipcode),
              ),
              DefaultButton(
                  texto: 'Salvar',
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Address editedAddress = new Address(
                          street: this._ctlStreet.text,
                          number: this._ctlNumber.text,
                          neighborhood: this._ctlNeighborhood.text,
                          complement: this._ctlComplement.text,
                          city: this._ctlCity.text,
                          state: this._ctlState.text,
                          zipCode: this._ctlZipcode.text);

                      await userModel
                          .editAddress(address, editedAddress)
                          .then((edited) {
                        if (edited) {
                          Navigator.pop(context);
                        } else {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(userModel.error.description),
                              backgroundColor: Colors.red,
                              action: SnackBarAction(
                                label: 'Desfazer',
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                      });
                    }
                  }),
            ],
          ),
          replacement: Loading(
            texto: 'Salvando o endereço...',
          ),
        ),
      ),
    );
  }
}
