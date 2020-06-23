import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/models/collect.dart';
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

  bool confirmar = false;

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
    confirmar = page == 4 ? true : false;
    notifyListeners();
  }

  ///Metodo para enviar o dados para API
  Future enviarColeta() async {
    setBusy(true);
    var resultApi = await _api.createCollect(collect);
    setBusy(false);
    return resultApi;
  }
}
