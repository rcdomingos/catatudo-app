import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:flutter/material.dart';

class AcceptCollectModel extends DefaultModel {
  Api _api;
  AcceptCollectModel({
    @required Api api,
  }) : _api = api;

  Future<ResponseApi> acceptCollect(String collectId, String codeStatus) async {
    setBusy(true);

    ResponseApi retornoRegister = new ResponseApi();
    bool resultApi = await _api.alterStatusCollect(collectId, codeStatus);

    if (resultApi) {
      retornoRegister.code = 201;
      retornoRegister.message = 'Coleta Aceita com Sucesso';
      retornoRegister.description =
          'Sua coleta foi agendada com sucesso, agora é só aguardar um coletor aceitar e confirmar a coleta na data e endereço informado!' +
              '\n A equipe do CataTudo e o Planeta agradecem a sua participação';
    } else {
      retornoRegister = _api.responseApi;
    }
    setBusy(false);
    return retornoRegister;
  }
}
