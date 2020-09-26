import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/models/collect.dart';
import 'package:catatudo_app/core/models/response_api.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';

class AddCollectModel extends DefaultModel {
  Api _api;
  AddCollectModel({
    Api api,
  }) : _api = api;

  int _typeSelectedIndex;
  int get typeSelectedIndex => _typeSelectedIndex;

  int _addressSelectedIndex;
  int get addressSelectedIndex => _addressSelectedIndex;

  List _types = ['Recicláveis', 'Eletronicos', 'Óleo'];
  List get types => _types;

  int _timeRadioValue;
  int get timeRadioValue => _timeRadioValue;

  ResponseApi _error;
  ResponseApi get error => _error;

  bool confirmar = false;
  bool goHome = true;

  ///Variaveis para envio da API
  Collect collect = new Collect();

  ///Metodo para selecionar o tipo de coleta
  void setSelectedIndex(int index) {
    _typeSelectedIndex = index;
    collect.collectType = _types[index];
    notifyListeners();
  }

  /// Metodo para selecionar o endereço da coleta
  void setSelectedAddress(int index, Address address) {
    _addressSelectedIndex = index;
    collect.address = address;
    notifyListeners();
  }

  ///Metodo para selecioar a data da coleta
  void setDateCollect(DateTime date) {
    collect.collectDate = date.toString();
    notifyListeners();
  }

  ///Metodo para selecionar o periodo
  void setTimeRadioCollect(int value) {
    _timeRadioValue = value;
    value == 1 ? collect.collectTime = 'Tarde' : collect.collectTime = 'Manhã';
    notifyListeners();
  }

  ///Metodo para ativar o botão de enviar coleta
  void setButtonConfirmar(int page) {
    print(page);
    confirmar = page == 4 ? true : false;
    goHome = page == 0 ? true : false;
    notifyListeners();
  }

  ///Metodo para enviar o dados da coleta para API
  Future<ResponseApi> enviarColeta() async {
    setBusy(true);
    ResponseApi retornoRegister = new ResponseApi();
    bool resultApi = await _api.createCollect(collect);

    if (resultApi) {
      retornoRegister.code = 201;
      retornoRegister.message = 'Coleta Agendada com Sucesso';
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
