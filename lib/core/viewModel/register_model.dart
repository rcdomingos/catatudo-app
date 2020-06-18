import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:flutter/material.dart';

class RegisterModel extends DefaultModel {
  Api _api;
  RegisterModel({
    @required Api api,
  }) : _api = api;

  String retornoRegister;

  Future register(String name, String email, String password) async {
    setBusy(true);

    retornoRegister = await _api.createUser(name, email, password);
    print(retornoRegister);

    setBusy(false);

    return retornoRegister;
  }
}
