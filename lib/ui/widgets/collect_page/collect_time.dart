import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectTime extends StatelessWidget {
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
                    'NOS INFORME O MELHOR PERÍODO PARA REALIZAR A COLETA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40),
              Container(
                height: 150,
                child: Container(
                  width: 200,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                              value: 0,
                              groupValue: model.timeRadioValue,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                model.setTimeRadioCollect(value);
                              }),
                          Text(
                            'Manhã',
                            style: TextStyle(
                                fontSize: 20,
                                color: (model.timeRadioValue == 0)
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: 1,
                              groupValue: model.timeRadioValue,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                model.setTimeRadioCollect(value);
                              }),
                          Text(
                            'Tarde',
                            style: TextStyle(
                                fontSize: 20,
                                color: (model.timeRadioValue == 1)
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ],
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
