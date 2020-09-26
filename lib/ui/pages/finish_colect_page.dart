import 'package:catatudo_app/core/models/collect.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/accept_collect_model.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/widget_base_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FinishColectPage extends StatelessWidget {
  Collect collect;

  @override
  Widget build(BuildContext context) {
    this.collect = ModalRoute.of(context).settings.arguments;

    return BaseWidget<AcceptCollectModel>(
      model: AcceptCollectModel(api: Provider.of<Api>(context)),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            DefaultAppBar(
              title: 'Detalhes da Coleta',
              subTitle: 'Verifique as informações sobre a coleta',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      alignment: Alignment.center,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1.0, color: Theme.of(context).primaryColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ATENÇÃO COLETOR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Após realizar a coleta na data agendada clique em "finalizar coleta" para finalizar o processo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        height: 200,
                        child: Container(
                          width: double.maxFinite,
                          padding:
                              EdgeInsets.only(top: 10, left: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1.0,
                                color: Theme.of(context).primaryColor),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ListView(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.recycle),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Material para coleta',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(collect.collectType),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.mapMarked),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Endereço para coleta',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(collect.address.city.toUpperCase() +
                                          ' - ' +
                                          collect.address.state),
                                      Text(
                                        collect.address.street +
                                            (collect.address.number != null
                                                ? ', nº ' +
                                                    collect.address.number
                                                : ''),
                                      ),
                                      collect.address.complement != null
                                          ? Text(collect.address.complement)
                                          : SizedBox(),
                                      Text(collect.address.neighborhood),
                                      Text(collect.address.zipCode),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.date_range),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Data para coleta',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(
                                                collect.collectDate)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Perido para coleta',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(collect.collectTime)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DefaultButton(
                texto: 'Finalizar Coleta',
                onPressed: () {
                  model.acceptCollect(collect.sId, '3').then((responseApi) => {
                        if (responseApi.code == 201)
                          {
                            Navigator.of(context).pop(true),
                          }
                      });
                })
          ],
        ),
      ),
    );
  }
}
