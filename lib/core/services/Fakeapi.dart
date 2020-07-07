import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/models/collect.dart';
import 'package:catatudo_app/core/models/feed.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:dio/dio.dart';

const String SERVER_URL = 'http://192.168.1.16:3001/api/v1';
var client = new http.Client();

class Api {
  Dio dio = Dio();
  String _userJwt;
  String get userjwt => _userJwt;

  ///Metodo para fazer o login do usuario retornando o JWT
  Future<String> createJWT(String email, String password) async {
    // final http.Response response = await http.post(
    //   "$SERVER_URL/create-auth",
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(
    //     <String, String>{
    //       'email': email,
    //       'password': password,
    //     },
    //   ),
    // );

    // // print('Response body: ${user['auth_token']}');
    // Map<String, dynamic> user = jsonDecode(response.body);

    // if (response.statusCode == 201) {
    //   await _storage.write(key: "jwt", value: user['auth_token']);
    //   return (user['auth_token']);
    // } else {
    //   throw StateError(user['message']);
    // }
    this._userJwt = jwt;
    return jwt;
  }

  ///Metodo para buscar as informações do usuario na Api
  Future<User> getUserProfile(String userID, String jwt) async {
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
    await _fakeApiTest(2);

    return User.fromJson(userTeste);
  }

  ///Metodo enviar e cadastrar o usuario para Api
  Future<String> createUser(String name, String email, String password) async {
    // try {
    //   final http.Response response = await http.post(
    //     SERVER_URL,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(
    //       <String, String>{
    //         'name': name,
    //         'email': email,
    //         'password': password,
    //       },
    //     ),
    //   );
    //   // print('Response body: ${response.body}');
    //   if (response.statusCode == 201) {
    //     return 'Usuario Cadastrado com Sucesso';
    //   } else if (response.statusCode >= 500) {
    //     throw StateError(
    //         'No momento estamos com algum erro em nosso servidor, Estamos ajustando por favor tente mais tarde');
    //   } else {
    //     throw StateError('Não foi possivel cadastrar o usuario');
    //   }
    // } catch (e) {
    //   print('erro:');
    //   print(e.toString());
    //   return e.toString();
    // }

    await _fakeApiTest(3);

    print('Cadastrando o usuario ' + name);
    return 'Usuario Cadastrado com Sucesso';
  }

  Future editUserProfile({
    String id,
    String name,
    String email,
    String phone,
    File file,
  }) async {
    try {
      var url = '$SERVER_URL/users/$id';
      String fileName = file.path.split('/').last;
      final image = await MultipartFile.fromFile(file.path, filename: fileName);

      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $userjwt',
      };
      print(userjwt);
      FormData formData =
          FormData.fromMap({"name": name, "email": email, "image": image});

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

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
  }

  ///Metodo para buscar a lista  dos Feeds na Api */
  Future<List<Feed>> getNewsFeeds() async {
    ///TODO:Implementar as regras e chamada para API

    var feeds = List<Feed>();

// Response response = await client.get("$SERVER_URL/feeds");

// var listFeeds = jsonDecode(response.body) as List<dynamic>;

    // var listFeeds = fakeFeeds as List<dynamic>;

    // articles.forEach((article) => feeds.add(Feed.fromJson(article)));

    // var listFeeds = jsonDecode(fakeFeeds) as List<dynamic>;

    for (var feed in fakeFeeds) {
      feeds.add(Feed.fromJson(feed));
    }

    return feeds;
  }

  ///Metodo para enviar o novo endereço para Api
  Future addUserAdress(String address) async {
    print('Future API' + address);

    String teste = 'Teste ok';

    return teste;
  }

  ///Metodo para enviar o endereço alterado para Api
  Future editUserAddres(int codAdress, Address editedAddress) async {
    ///TODO:Implementar as regras e chamada para API
    try {
      var statusCode = 202;
      return statusCode;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> createCollect(Collect collect) async {
    try {
      await _fakeApiTest(2);
      print('Api ' + collect.collectType);
      return true;
    } catch (e) {
      print(e.toString());
    }
  }

  ///Metodo para buscar as coletas
  Future<List<Collect>> getCollections() async {
    var collections = List<Collect>();

    for (var collect in fakecoletas) {
      collections.add(Collect.fromJson(collect));
    }

    print('entrou na APi' + collections.length.toString());
    return collections;
  }

  ///FAKE API para testes
  Future<bool> _fakeApiTest(int timer) {
    return Future.delayed(Duration(seconds: timer)).then((onValue) => false);
  }
}

///Dados para teste of line

String jwt =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWVjZWM3YzI2NWY2MjcyODM4ODAwMjczIiwibmFtZSI6IlJlZ2luYWxkbyBDIiwiZW1haWwiOiJyY2RvbWluZ29zQGZhdGVjLmNvbSIsImlhdCI6MTU5MDYxNTcxOCwiZXhwIjoxNjIyMTUxNzE4fQ.iQYLD1WQR2J03b0gCIt2QqbCBvTV4KKbUO6_65NtHFQ";

var userTeste = {
  "_id": "5ecec7c265f6272838800273",
  "name": "Reginaldo C Domingos",
  "email": "rcdomingos@fatec.com",
  "isCollector": false,
  "isAdmin": false,
  "image":
      "https://avatars1.githubusercontent.com/u/39439355?s=460&u=3b9182f05983670039cf991e6f7454697e5789d2&v=4",
  "created_date": "2020-05-27T20:04:18.919Z",
  "addresses": [
    {
      "codAddress": 1,
      "street": "Av Monteiro Lobato.",
      "number": "302",
      "neighborhood": "Centro",
      "complement": "apt 7",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-430"
    },
    {
      "codAddress": 3,
      "street": "Rua Leopoldor.",
      "number": "800",
      "neighborhood": "Itaim",
      "complement": "7° andar",
      "city": "São Paulo",
      "state": "SP",
      "zipCode": "18120-000"
    },
    {
      "codAddress": 4,
      "street": "Getulio Vargas.",
      "number": "800",
      "neighborhood": "Marmeleiro",
      "complement": "7° andar",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-000"
    },
    {
      "codAddress": 1,
      "street": "Av Monteiro Lobato.",
      "number": "302",
      "neighborhood": "Centro",
      "complement": "apt 7",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-430"
    },
  ]
};

var fakeFeeds = [
  {
    "id": "1321321",
    "title": "Descarte Corretamente",
    "subtitle": "Apreenda descarta o lixo corretamente",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et congue elit. Vestibulum euismod aliquet tristique. Sed eu porta nulla. Cras imperdiet tristique viverra. Suspendisse gravida odio ac malesuada mattis. Nam venenatis leo consequat varius mollis. Aliquam ut ante vitae justo tincidunt fermentum vel a ipsum. Praesent porta vel metus in iaculis. Fusce dignissim convallis dui quis aliquet. Integer efficitur massa lacus, vel feugiat mauris lobortis sed. Nunc mi neque, tempor ullamcorper nunc vitae, ultrices tempor ex. Mauris venenatis orci lobortis nisl consequat ullamcorper. Nunc in mi mi. Aliquam vitae ligula vestibulum, maximus tellus eu, placerat libero.",
    "image":
        "https://www.estudokids.com.br/wp-content/uploads/2019/04/reciclagem-o-que-e-importancia-1200x675.jpg"
  },
  {
    "id": "1321321",
    "title": "Dicas de Discart",
    "subtitle": "Separando o lixo da maneira correta",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et congue elit. Vestibulum euismod aliquet tristique. Sed eu porta nulla. Cras imperdiet tristique viverra. Suspendisse gravida odio ac malesuada mattis. Nam venenatis leo consequat varius mollis. Aliquam ut ante vitae justo tincidunt fermentum vel a ipsum. Praesent porta vel metus in iaculis. Fusce dignissim convallis dui quis aliquet. Integer efficitur massa lacus, vel feugiat mauris lobortis sed. Nunc mi neque, tempor ullamcorper nunc vitae, ultrices tempor ex. Mauris venenatis orci lobortis nisl consequat ullamcorper. Nunc in mi mi. Aliquam vitae ligula vestibulum, maximus tellus eu, placerat libero.",
    "image":
        "https://static.vix.com/pt/sites/default/files/r/reciclagem-lixo-materiais-1019-1400x800.jpg"
  },
  {
    "id": "1321321",
    "title": "Voce descarta corretamente?",
    "subtitle": "Faça o teste e decubra se você descarta o lixo corretamente",
    "body":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et congue elit. Vestibulum euismod aliquet tristique. Sed eu porta nulla. Cras imperdiet tristique viverra. Suspendisse gravida odio ac malesuada mattis. Nam venenatis leo consequat varius mollis. Aliquam ut ante vitae justo tincidunt fermentum vel a ipsum. Praesent porta vel metus in iaculis. Fusce dignissim convallis dui quis aliquet. Integer efficitur massa lacus, vel feugiat mauris lobortis sed. Nunc mi neque, tempor ullamcorper nunc vitae, ultrices tempor ex. Mauris venenatis orci lobortis nisl consequat ullamcorper. Nunc in mi mi. Aliquam vitae ligula vestibulum, maximus tellus eu, placerat libero.",
    "image":
        "https://blog.brkambiental.com.br/wp-content/uploads/2019/07/original-b742306ee3cd42b3c57b1a4b986bcb0c.jpg"
  }
];

var fakecoletas = [
  {
    "collectType": "Reciclaveis",
    "collectDate": "2020-06-27T20:04:18.919Z",
    "collectTime": "Tarde",
    "status": "Aguardando",
    "createdDate": "2020-05-27T20:04:18.919Z",
    "addresses": {
      "codAddress": 1,
      "street": "Av Monteiro Lobato.",
      "number": "302",
      "neighborhood": "Centro",
      "complement": "apt 7",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-430"
    },
  },
  {
    "collectType": "Óleo",
    "collectDate": "2021-06-27T20:04:18.919Z",
    "collectTime": "Tarde",
    "status": "Aguardando",
    "createdDate": "2020-05-27T20:04:18.919Z",
    "addresses": {
      "codAddress": 1,
      "street": "Av Monteiro Lobato.",
      "number": "302",
      "neighborhood": "Centro",
      "complement": "apt 7",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-430"
    },
  },
  {
    "collectType": "Óleo",
    "collectDate": "2022-06-27T20:04:18.919Z",
    "collectTime": "Tarde",
    "status": "Aguardando",
    "created_date": "2020-05-27T20:04:18.919Z",
    "addresses": {
      "codAddress": 1,
      "street": "Av Monteiro Lobato.",
      "number": "302",
      "neighborhood": "Centro",
      "complement": "apt 7",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-430"
    },
  },
  {
    "collectType": "Recicláveis",
    "collectDate": "2020-06-27T20:04:18.919Z",
    "collectTime": "Tarde",
    "status": "Aguardando",
    "createdDate": "2020-05-27T20:04:18.919Z",
    "addresses": {
      "codAddress": 1,
      "street": "Av Monteiro Lobato.",
      "number": "302",
      "neighborhood": "Centro",
      "complement": "apt 7",
      "city": "São Roque",
      "state": "SP",
      "zipCode": "18120-430"
    },
  }
];
