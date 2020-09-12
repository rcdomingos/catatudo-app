import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/profile_page/add_address_form.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  var _ctlStreet = new TextEditingController();
  var _ctlNumber = new TextEditingController();
  var _ctlNeighborhood = new TextEditingController();
  var _ctlComplement = new TextEditingController();
  var _ctlCity = new TextEditingController();
  var _ctlState = new TextEditingController();
  var _ctlZipcode = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: <Widget>[
              DefaultAppBar(
                title: 'Novo Endereço',
                subTitle: 'Cadastre seu endereço de coleta',
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Visibility(
                    visible: !model.busy,
                    child: Column(
                      children: <Widget>[
                        AddAddressForm(
                            formKey: this._formKey,
                            ctlStreet: this._ctlStreet,
                            ctlNumber: this._ctlNumber,
                            ctlNeighborhood: this._ctlNeighborhood,
                            ctlComplement: this._ctlComplement,
                            ctlCity: this._ctlCity,
                            ctlState: this._ctlState,
                            ctlZipcode: this._ctlZipcode),
                        DefaultButton(
                          texto: 'Cadastrar',
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              Address address = new Address(
                                street: this._ctlStreet.text,
                                number: this._ctlNumber.text,
                                neighborhood: this._ctlNeighborhood.text,
                                city: this._ctlCity.text,
                                state: this._ctlState.text,
                                zipCode: this._ctlZipcode.text,
                              );

                              await model.addNewAddress(address).then((added) {
                                if (added) {
                                  Navigator.pop(context);
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(model.error.description),
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
                            } else {
                              model.setValidate(true);
                            }
                          },
                        ),
                      ],
                    ),
                    replacement: Loading(
                      texto: 'Cadastrando o novo endereço...',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
