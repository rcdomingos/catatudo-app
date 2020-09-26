import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/collect.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/collections_model.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';
import 'package:catatudo_app/ui/widgets/widget_base_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AcceptedCollectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserModel>(context).user;

    return BaseWidget<CollectionsModel>(
      model: CollectionsModel(api: Provider.of<Api>(context)),
      onModelReady: (model) => model.getAccetpCollections(user.sId),
      builder: (context, model, child) => Container(
        alignment: Alignment.topCenter,
        child: Visibility(
          visible: model.busy,
          child: Loading(
            texto: 'Carregando as coletas...',
          ),
          replacement: ListView.builder(
              itemCount:
                  (model.collections != null) ? model.collections.length : 0,
              itemBuilder: (BuildContext context, int index) {
                Collect collect = model.collections.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.FINISH_COLLECT_PAGE,
                            arguments: collect)
                        .then((retorno) {
                      if (retorno == true) {
                        model.getAccetpCollections(user.sId);
                      }
                    });
                  },
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'COLETA AGENDADA NO DIA: ',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(collect.createdDate)),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'DATA: ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(
                                                    collect.collectDate)),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'PERIODO: ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            collect.collectTime,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'MATERIAL: ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            collect.collectType,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'STATUS: ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            collect.status.description,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
