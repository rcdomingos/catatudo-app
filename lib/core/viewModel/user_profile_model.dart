import 'dart:io';
import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';

class UserModel extends DefaultModel {
  Api _api;
  UserModel({
    Api api,
  }) : _api = api;

  User _user = User();
  User get user => _user;

  ResponseApi _error;
  ResponseApi get error => _error;

  void setUser(User user) {
    this._user = user;
    notifyListeners();
  }

  ///Metodo para adiciona um novo endereço do usuario
  Future<bool> addNewAddress(Address address) async {
    setBusy(true);

    _error = new ResponseApi();
    bool _added = true;
    Address _newAddress = await _api.addUserAdress(user.sId, address);

    if (_newAddress != null) {
      this._user.addresses.add(_newAddress);
      notifyListeners();
    } else {
      _error = _api.responseApi;
      _added = false;
    }
    setBusy(false);
    return _added;
  }

  ///Metodo para deletar um endereço do usuario
  Future<bool> deleteUserAddress(Address address) async {
    setBusy(true);
    _error = new ResponseApi();
    bool _deleted = true;
    bool resp = await _api.deleteUserAddress(user.sId, address.codAddress);

    if (resp) {
      this._user.addresses.remove(address);
      notifyListeners();
    } else {
      _error = _api.responseApi;
      _deleted = false;
    }
    setBusy(false);
    return _deleted;
  }

  ///Metodo para alterar o endereço do usuario
  Future<bool> editAddress(Address address, Address editedAddress) async {
    setBusy(true);
    _error = new ResponseApi();
    bool _edited = true;
    int index = this._user.addresses.indexOf(address);

    await _api
        .editUserAddress(user.sId, address.codAddress, editedAddress)
        .then((resp) {
      if (resp) {
        this._user.addresses.elementAt(index).street = editedAddress.street;
        this._user.addresses.elementAt(index).number = editedAddress.number;
        this._user.addresses.elementAt(index).neighborhood =
            editedAddress.neighborhood;
        this._user.addresses.elementAt(index).complement =
            editedAddress.complement;
        this._user.addresses.elementAt(index).city = editedAddress.city;
        this._user.addresses.elementAt(index).state = editedAddress.state;
        this._user.addresses.elementAt(index).zipCode = editedAddress.zipCode;
        notifyListeners();
      } else {
        _error = _api.responseApi;
        _edited = false;
      }
    }).catchError((onError) {
      _error = _api.responseApi;
      _edited = false;
    });

    setBusy(false);
    return _edited;
  }

  ///Metodo para chamar a api de alteração do usuario
  Future<bool> editUserProfile(
      {String name, String email, String phone, File image}) async {
    setBusy(true);
    _error = new ResponseApi();
    bool _edited = true;

    User _editedUser = await _api.editUserProfile(
      id: user.sId,
      name: name,
      email: email,
      phone: phone,
      file: image,
    );

    if (_editedUser != null) {
      this._user.name = _editedUser.name;
      this._user.email = _editedUser.email;
      this._user.phone = _editedUser.phone;
      this._user.image = _editedUser.image;
      notifyListeners();
    } else {
      _error = _api.responseApi;
      _edited = false;
    }

    setBusy(false);
    return _edited;
  }
}
