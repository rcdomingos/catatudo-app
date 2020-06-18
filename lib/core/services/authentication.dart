import 'dart:convert';
import 'dart:async';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/services/api.dart';

class AuthenticationService {
  final Api _api;
  AuthenticationService({Api api}) : _api = api;

  // StreamController<User> _userController = StreamController<User>();

  // Stream<User> get user => _userController.stream;

  ///Metodo para fazer o login do usuario gerando o JWT e pegando os dados do usuario
  Future<User> login(String userEmail, String userPass) async {
    bool hasUser = false;

    ///pegar o jWT na API
    var jwtUser = await _api.createJWT(userEmail, userPass);

    User fetchedUser;

    ///converter o JWT e trazer o ID do usuario
    String _userId = _getUserIdJwt(jwtUser);

    if (jwtUser != null && _userId != null) {
      ///pegar as informações do usuario via API
      fetchedUser = await _api.getUserProfile(_userId, jwtUser);

      hasUser = fetchedUser != null;

      // if (hasUser) {
      //   _userController.add(fetchedUser);
      // }
    }

    return fetchedUser;
  }

  /// Pegar o ID do usuario do token JWT
  String _getUserIdJwt(jwt) {
    var decodeJwt = json.decode(
      ascii.decode(
        base64.decode(
          base64.normalize(jwt.split(".")[1]),
        ),
      ),
    );
    if (decodeJwt['user_id'] != null) {
      return decodeJwt['user_id'];
    } else {
      return null;
    }
  }
}
