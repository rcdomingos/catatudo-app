import 'dart:async';
import 'dart:convert';

import 'package:catatudo_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final _storage = new FlutterSecureStorage();

Map<String, String> userTeste = {
  "name": "Reginaldo C",
  "email": "rcdomingos@fatec.com",
  "password": "123"
};

const SERVER_URL = 'http://192.168.1.16:3001/api/v1/users';

class UserController {
  User user;

  ///Metodo para cadastrar o usuario
  Future<String> createUser(String name, String email, String password) async {
    try {
      final http.Response response = await http.post(
        SERVER_URL,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      // print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        return 'Usuario Cadastrado com Sucesso';
      } else if (response.statusCode >= 500) {
        throw StateError(
            'No momento estamos com algum erro em nosso servidor, Estamos ajustando por favor tente mais tarde');
      } else {
        throw StateError('Não foi possivel cadastrar o usuario');
      }
    } catch (e) {
      print('erro:');
      print(e.toString());
      return e.toString();
    }
  }

  ///Metodo para fazer o login do usuario (JWT)
  Future<String> userSingIn(String email, String password) async {
    final http.Response response = await http.post(
      "$SERVER_URL/create-auth",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      ),
    );

    // print('Response body: ${user['auth_token']}');
    Map<String, dynamic> user = jsonDecode(response.body);

    if (response.statusCode == 201) {
      await _storage.write(key: "jwt", value: user['auth_token']);
      return (user['auth_token']);
    } else {
      throw StateError(user['message']);
    }
  }

  ///Metodo para buscar as informações do usuario
  Future<User> getInfoUser(String userID, String jwt) async {
    // final response = await http.get("$SERVER_URL/$userID", headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $jwt',
    // });

    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   print(json.decode(response.body));
    //   return User.fromJson(json.decode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
    return User.fromJson(userTeste);
  }

  ///Carregar o jwt salvo
  Future<String> get jwtOrEmpty async {
    var jwt = await _storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }
}
