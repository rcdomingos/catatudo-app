import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/services/authentication.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:get_storage/get_storage.dart';

final _userLocalBox = GetStorage();

class StartModel extends DefaultModel {
  AuthenticationService _authenticationService;
  UserModel _userProfileModel;

  StartModel(
      {AuthenticationService authenticationService, UserModel userProfileModel})
      : _authenticationService = authenticationService,
        _userProfileModel = userProfileModel;

  ResponseApi _error;
  ResponseApi get error => _error;

  Future<bool> loginWithJwt() async {
    setBusy(true);
    bool _hasUserJwt = false;
    String _jwt;

    _jwt = await loadLocalJwt();

    if (_jwt != null) {
      var user = await _authenticationService.loginWithJwt(_jwt);

      if (user != null) {
        _userProfileModel.setUser(user);
        _hasUserJwt = true;
      } else {
        _hasUserJwt = false;
        _error = _authenticationService.authenticationError;
      }
    }
    setBusy(false);
    return _hasUserJwt;
  }
}

//Metodo usando o getStorage para carregar um dado
Future<String> loadLocalJwt() async {
  String _jwt;

  if (_userLocalBox.hasData('jwt')) {
    _jwt = _userLocalBox.read('jwt');
  }

  return _jwt;
}
