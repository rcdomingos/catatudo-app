import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollectResume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddCollectModel>(
      builder: (context, model, child) => Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.00),
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
                child: Text(
                    'CONFIRME AS INFORMAÇÕES DA COLETA E CLIQUE EM ENVIAR COLETA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  height: 200,
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                    child: ListView(
                      children: <Widget>[
                        (model.collect.collectType == null)
                            ? ListTile(
                                leading: Icon(FontAwesomeIcons.recycle,
                                    color: Colors.red),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Não informado',
                                    style: TextStyle(color: Colors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '\n' +
                                              'é necessario informar o tipo da coleta. ',
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ))
                            : ListTile(
                                leading: Icon(FontAwesomeIcons.recycle),
                                title: Text(model.collect.collectType),
                              ),
                        (model.collect.address == null)
                            ? ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.mapMarked,
                                  color: Colors.red,
                                ),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Não informado',
                                    style: TextStyle(color: Colors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '\n' +
                                              'é necessario informar o endereço. ',
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              )
                            : ListTile(
                                leading: Icon(FontAwesomeIcons.mapMarked),
                                title: Text(model.collect.address.city),
                                subtitle: Text(model.collect.address.street),
                              ),
                        (model.collect.collectDate == null)
                            ? ListTile(
                                leading: Icon(
                                  Icons.date_range,
                                  color: Colors.red,
                                ),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Não informado',
                                    style: TextStyle(color: Colors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '\n' +
                                              'é necessario informar a data da coleta. ',
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              )
                            : ListTile(
                                leading: Icon(Icons.date_range),
                                title: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(model.collect.collectDate),
                                ),
                              ),
                        (model.collect.collectTime == null)
                            ? ListTile(
                                leading: Icon(
                                  Icons.access_time,
                                  color: Colors.red,
                                ),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Não informado',
                                    style: TextStyle(color: Colors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '\n' +
                                              'é necessario informar o período para coleta. ',
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              )
                            : ListTile(
                                leading: Icon(Icons.access_time),
                                title: Text(model.collect.collectTime),
                              ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
