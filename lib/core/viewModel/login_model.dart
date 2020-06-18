import 'package:catatudo_app/core/services/authentication.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  AuthenticationService _authenticationService;
  UserModel _userProfileModel;

  LoginModel({
    AuthenticationService authenticationService,
    UserModel userProfileModel,
  })  : _authenticationService = authenticationService,
        _userProfileModel = userProfileModel;

  bool _busy = false;

  bool get busy => _busy;

  String _jwt;

  Future<bool> login(String userEmail, String userPass) async {
    setBusy(true);

    var user = await _authenticationService.login(userEmail, userPass);

    _userProfileModel.setUser(user);

    setBusy(false);
    return true;
  }

  void setJWT(String value) {
    _jwt = value;
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
