import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';

class AddCollectModel extends DefaultModel {
  int _typeSelectedIndex;
  int get typeSelectedIndex => _typeSelectedIndex;

  int _addressSelectedIndex;
  int get addressSelectedIndex => _addressSelectedIndex;

  List _types = ['Recicláveis', 'Eletronicos', 'Óleo'];
  List get types => _types;

  String _type;

  void setSelectedIndex(int index) {
    _typeSelectedIndex = index;
    _type = _types[index];
    print(_type);
    notifyListeners();
  }

  void setSelectedAddress(int index, Address address) {
    _addressSelectedIndex = index;

    print(address.toJson());

    notifyListeners();
  }
}
