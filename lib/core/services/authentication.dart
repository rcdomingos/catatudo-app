import 'dart:convert';
import 'dart:async';
import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:get_storage/get_storage.dart';

final _userLocalBox = GetStorage();

class AuthenticationService {
  final Api _api;
  AuthenticationService({Api api}) : _api = api;

  ResponseApi authenticationError;

  ///Metodo para fazer o login do usuario gerando o JWT e pegando os dados do usuario
  Future<User> login(String userEmail, String userPass) async {
    authenticationError = null;

    ///pegar o jWT na API
    var respApi = await _api.createJWT(userEmail, userPass);

    User fetchedUser;

    if (respApi['code'] == 201) {
      createLocalJwt(respApi['jwt']);

      ///converter o JWT e trazer o ID do usuario
      String _userId = _getUserIdJwt(respApi['jwt']);

      if (respApi['jwt'] != null && _userId != null) {
        ///pegar as informações do usuario via API
        fetchedUser = await _api.getUserProfile(_userId, respApi['jwt']);
      }
    } else {
      authenticationError = new ResponseApi(
        code: respApi['code'],
        message: respApi['message'],
        description: respApi['description'],
      );
    }

    // print(_userLocalBox.read('jwt'));

    return fetchedUser;
  }

  ///MEtodo para fazer o login com o JWT e rotarnar o usuario
  Future<User> loginWithJwt(String jwt) async {
    authenticationError = null;

    User fetchedUser;

    String _userId = _getUserIdJwt(jwt);

    fetchedUser = await _api.getUserProfile(_userId, jwt);

    if (fetchedUser == null) {
      authenticationError = _api.responseApi;
      print(authenticationError.description);
    }

    return fetchedUser;
  }

  //Metodo usando o getStora para salva um dado
  Future createLocalJwt(String jwt) async {
    return await _userLocalBox.write('jwt', jwt);
  }

  /// Excluir o jwt local da memoria

  Future<void> deleteLocalJwt() async {
    await _userLocalBox.remove('jwt');
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
    if (decodeJwt['userId'] != null) {
      return decodeJwt['userId'];
    } else {
      return null;
    }
  }
}
