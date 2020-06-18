import 'package:flutter/material.dart';

class DefaultModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  bool _validate = false;
  bool get validate => _validate;

//Metodo para Alterar o status da requisição
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ///Metodo para alterar o status do validade dos forms */
  void setValidate(bool value) {
    _validate = value;
    notifyListeners();
  }
}
