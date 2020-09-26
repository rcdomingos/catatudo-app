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

  ///Listar as coletas em aberto para o coletor
  void getCollections() async {
    setBusy(true);

    collections = await _api.getCollections(status: '1');

    setBusy(false);
  }

  ///Listar as coletas pelo id do usuario
  void getUserCollections(userId) async {
    setBusy(true);

    collections = await _api.getCollections(generatorId: userId);

    setBusy(false);
  }

  void getAccetpCollections(collectorId) async {
    setBusy(true);

    collections = await _api.getCollections(
      collectorId: collectorId,
      status: '2',
    );

    setBusy(false);
  }
}
