import 'package:catatudo_app/core/models/feed.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/default_model.dart';
import 'package:flutter/material.dart';

class FeedModel extends DefaultModel {
  Api _api;
  FeedModel({
    @required Api api,
  }) : _api = api;

  List<Feed> feeds;

  Future getFeeds() async {
    setBusy(true);

    feeds = await _api.getNewsFeeds();

    print('Api Retorno com ' + feeds.length.toString() + 'feeds');

    setBusy(false);
  }
}
