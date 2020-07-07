import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:flutter/material.dart';

class RegisterModel extends DefaultModel {
  Api _api;
  RegisterModel({
    @required Api api,
  }) : _api = api;

  ResponseApi retornoRegister;

  Future<ResponseApi> register(
      String name, String email, String password) async {
    setBusy(true);

    retornoRegister = await _api.createUser(name, email, password);

    setBusy(false);

    return retornoRegister;
  }
}
