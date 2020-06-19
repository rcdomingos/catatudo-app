import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectType extends StatelessWidget {
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
                    'NOS INFORME AQUI O TIPO DE MATERIAL A SER COLETADO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: (model.types != null) ? model.types.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          model.setSelectedIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: model.typeSelectedIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                          child: Text(
                            model.types[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: model.typeSelectedIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
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
