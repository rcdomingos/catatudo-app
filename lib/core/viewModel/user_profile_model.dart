import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UserModel extends DefaultModel {
  Api _api;
  UserModel({
    Api api,
  }) : _api = api;

  User _user = User();

  User get user => _user;

  void setUser(User user) {
    this._user = user;
    notifyListeners();
  }

  ///Metodo para adiciona um novo endereço do usuario
  void addAddress(Address address) {
    setBusy(true);
    print(_user.name);
    //TODO: adicionar a chamada a API
    _api.addUserAdress('Endereço de teste');

    print(address.toJson());
    this._user.addresses.add(address);
    notifyListeners();
    setBusy(false);
  }

  ///Metodo para alterar o endereço do usuario
  void deleteAddress(Address address) {
    setBusy(true);
    //TODO: adicionar a chamada a API
    this._user.addresses.remove(address);
    notifyListeners();
    setBusy(false);
  }

  ///Metodo para alterar o endereço do usuario
  Future<bool> editAddress(Address address, Address editedAddress) async {
    setBusy(true);
    var index = this._user.addresses.indexOf(address);
    print("Alterando o endereço: $index");

    //TODO: adicionar a chamada a API
    var retornoApi = _api.editUserAddres(address.codAddress, editedAddress);

    print("Retorno da API: $retornoApi");

    this._user.addresses.elementAt(index).street = editedAddress.street;
    this._user.addresses.elementAt(index).number = editedAddress.number;
    this._user.addresses.elementAt(index).neighborhood =
        editedAddress.neighborhood;
    this._user.addresses.elementAt(index).complement = editedAddress.complement;
    this._user.addresses.elementAt(index).city = editedAddress.city;
    this._user.addresses.elementAt(index).state = editedAddress.state;
    this._user.addresses.elementAt(index).zipCode = editedAddress.zipCode;
    notifyListeners();

    setBusy(false);

    return true;
  }
}
