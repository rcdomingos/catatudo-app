import 'package:catatudo_app/core/models/collect.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:flutter/material.dart';

class CollectionsModel extends DefaultModel {
  Api _api;
  CollectionsModel({
    @required Api api,
  }) : _api = api;

  List<Collect> collections;

  void getCollections() async {
    setBusy(true);

    collections = await _api.getCollections();

    setBusy(false);
  }
}
