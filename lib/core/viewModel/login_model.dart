import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/services/authentication.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';

class LoginModel extends DefaultModel {
  AuthenticationService _authenticationService;
  UserModel _userProfileModel;

  LoginModel({
    AuthenticationService authenticationService,
    UserModel userProfileModel,
  })  : _authenticationService = authenticationService,
        _userProfileModel = userProfileModel;

  ResponseApi _error;
  ResponseApi get error => _error;

  Future<bool> login(String userEmail, String userPass) async {
    setBusy(true);
    bool _hasUser = true;
    var user = await _authenticationService.login(userEmail, userPass);

    if (user != null) {
      _userProfileModel.setUser(user);
    } else {
      _hasUser = false;
      _error = _authenticationService.authenticationError;
    }

    setBusy(false);
    return _hasUser;
  }
}
