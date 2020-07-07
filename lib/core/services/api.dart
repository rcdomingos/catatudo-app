import 'dart:convert';
import 'dart:io';
import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/models/collect.dart';
import 'package:catatudo_app/core/models/feed.dart';
import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:dio/dio.dart';

// const String SERVER_URL = 'http://192.168.1.16:3001/api/v1';
const String SERVER_URL = 'http://192.168.1.15:3001/api/v1';

class Api {
  Dio dio = Dio();
  String _userJwt;
  String get userjwt => _userJwt;

  ResponseApi _responseApi = new ResponseApi();
  ResponseApi get responseApi => _responseApi;

  ///Metodo para buscar as informações do usuario na Api
  Future<User> getUserProfile(String userID, String jwt) async {
    try {
      var url = '$SERVER_URL/users/$userID';
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      };

      final Response response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      this._userJwt = jwt;

      if (response.statusCode == 200) {
        // return User.fromJson(json.decode(response.data));
        return User.fromJson(response.data);
      } else {
        _responseApi = new ResponseApi.fromJson(response.data);
        return null;
      }
    } catch (e) {
      print(e.toString());
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro para alterar o Perfil',
        description: e.toString(),
      );
      return null;
    }
  }

  ///Metodo enviar e cadastrar o usuario para Api
  Future<ResponseApi> createUser(
      String name, String email, String password) async {
    ResponseApi resp;
    try {
      var url = '$SERVER_URL/users/';
      var headers = {'Content-Type': 'application/json; charset=UTF-8'};

      var formData = jsonEncode(
        <String, String>{
          'name': name,
          'email': email,
          'password': password,
        },
      );

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      resp = new ResponseApi.fromJson(response.data);
    } catch (e) {
      resp = new ResponseApi(
        code: 500,
        message: 'Erro para Cadastrar o Usuario',
        description: e.toString(),
      );
    }
    return resp;
  }

  /// Metodo para fazer o login do usuario retornando o JWT
  Future<Map> createJWT(String email, String password) async {
    try {
      var url = '$SERVER_URL/users/create-auth';
      var headers = {'Content-Type': 'application/json; charset=UTF-8'};

      var formData = jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      );

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      var jsonData = await response.data;

      if (response.statusCode == 201) {
        var jwt = jsonData['auth_token'];

        return {"code": response.statusCode, "jwt": jwt};
      } else {
        return {
          "code": jsonData['code'],
          "message": jsonData['message'],
          "description": jsonData['description'],
        };
      }
    } catch (e) {
      return {
        "code": 500,
        "message": 'Erro no Aplicativo',
        "description": e.toString(),
      };
    }
  }

  /// Metodo para alterar as informações do usuario
  Future<User> editUserProfile(
      {String id, String name, String email, String phone, File file}) async {
    try {
      var url = '$SERVER_URL/users/$id';

      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $userjwt',
      };

      FormData formData;
      if (file != null) {
        String fileName = file.path.split('/').last;
        final image =
            await MultipartFile.fromFile(file.path, filename: fileName);
        formData = FormData.fromMap(
            {"name": name, "email": email, "image": image, "phone": phone});
      } else {
        formData =
            FormData.fromMap({"name": name, "email": email, "phone": phone});
      }

      Response response = await dio.put(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      print(response.statusCode);

      if (response.statusCode == 202) {
        return User.fromJson(response.data);
      } else {
        _responseApi = new ResponseApi.fromJson(response.data);
        return null;
      }
    } catch (e) {
      print(e.toString());
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro para alterar o Perfil',
        description: e.toString(),
      );
      return null;
    }
  }

  ///Metodo para enviar um novo endereço para Api
  Future<Address> addUserAdress(String userID, Address address) async {
    try {
      var url = '$SERVER_URL/users/$userID/address/';
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userjwt',
      };

      var formData = jsonEncode(
        <String, String>{
          'street': address.street,
          'number': address.number,
          'neighborhood': address.neighborhood,
          'complement': address.complement,
          'city': address.city,
          'state': address.state,
          'zipCode': address.zipCode,
        },
      );

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        return Address.fromJson(response.data);
      } else {
        _responseApi = new ResponseApi.fromJson(response.data);
        return null;
      }
    } catch (err) {
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro no Aplicativo',
        description: err.toString(),
      );
      return null;
    }
  }

  ///Metodo para enviar o endereço alterado para Api
  Future<bool> editUserAddress(
      String userID, int codAddress, Address address) async {
    try {
      var url = '$SERVER_URL/users/$userID/address/$codAddress';

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userjwt',
      };

      var formData = jsonEncode(
        <String, String>{
          'street': address.street,
          'number': address.number,
          'neighborhood': address.neighborhood,
          'complement': address.complement,
          'city': address.city,
          'state': address.state,
          'zipCode': address.zipCode,
        },
      );

      final Response response = await dio.put(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        _responseApi = new ResponseApi.fromJson(response.data);
        return false;
      }
    } on DioError catch (err) {
      print(err.toString());
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro no Aplicativo',
        description: err.toString(),
      );
      return false;
    }
  }

  ///Metodo para excluir o endereço do usuario
  Future<bool> deleteUserAddress(String userID, int codAddress) async {
    try {
      var url = '$SERVER_URL/users/$userID/address/$codAddress';

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userjwt',
      };
      final Response response = await dio.delete(
        url,
        data: null,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 204) {
        return true;
      } else {
        _responseApi = new ResponseApi.fromJson(response.data);
        return false;
      }
    } on DioError catch (err) {
      print(err.toString());
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro no App para Deletar',
        description: err.toString(),
      );
      return false;
    }
  }

  ///Metodo para buscar a lista  dos Feeds na Api */
  Future<List<Feed>> getNewsFeeds() async {
    try {
      var url = '$SERVER_URL/feeds/';

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var feeds = List<Feed>();

      final Response response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      // print(response.data);
      for (var feed in response.data) {
        feeds.add(Feed.fromJson(feed));
      }
      return feeds;
    } catch (e) {
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro para Listar os Feeds',
        description: e.toString(),
      );
      return null;
    }
  }

  ///Metodo para buscar as coletas
  Future<List<Collect>> getCollections() async {
    try {
      var url = '$SERVER_URL/collections/';

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userjwt',
      };
      var collects = List<Collect>();

      final Response response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      print(response.statusCode);
      // print(response.data['results']);

      List results = response.data['results'];

      for (var collect in results) {
        collects.add(Collect.fromJson(collect));
      }
      return collects;
    } catch (err, stacktrace) {
      print("Exception occured: $err stackTrace: $stacktrace");
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro para Listar as Coletas',
        description: err.toString(),
      );
      return null;
    }
  }

  ///Metodo para adicionar uma nova coleta
  Future<bool> createCollect(Collect collect) async {
    try {
      var url = '$SERVER_URL/collections/';

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userjwt',
      };

      var formData = jsonEncode(
        <String, dynamic>{
          'collectType': collect.collectType,
          'collectDate': collect.collectDate,
          'collectTime': collect.collectTime,
          'address': {
            'codAddress': collect.address.codAddress,
            'street': collect.address.street,
            'number': collect.address.number,
            'complement': collect.address.complement,
            'city': collect.address.city,
            'state': collect.address.state,
            'zipCode': collect.address.zipCode,
          },
        },
      );

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        return true;
      } else {
        _responseApi = new ResponseApi.fromJson(response.data);
        return false;
      }
    } catch (err, stacktrace) {
      print("Exception occured: $err stackTrace: $stacktrace");
      _responseApi = new ResponseApi(
        code: 500,
        message: 'Erro para gerar a Coleta',
        description: err.toString(),
      );
      return false;
    }
  }

  ///FAKE API para testes
  Future<bool> _fakeApiTest(int timer) {
    return Future.delayed(Duration(seconds: timer)).then((onValue) => false);
  }
}
