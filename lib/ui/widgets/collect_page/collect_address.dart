import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Address> userAddress = Provider.of<UserModel>(context).user.addresses;

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
                child: Text('AGORA SELECIONE O ENDEREÇO DA COLETA',
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
                    itemCount: (userAddress != null) ? userAddress.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          model.setSelectedAddress(
                              index, userAddress.elementAt(index));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                            color: model.addressSelectedIndex == index
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                userAddress.elementAt(index).city,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: model.addressSelectedIndex == index
                                      ? Colors.white
                                      : Colors.grey[600],
                                ),
                              ),
                              Text(
                                userAddress.elementAt(index).street +
                                    userAddress.elementAt(index).number,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: model.addressSelectedIndex == index
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                              Text(
                                userAddress.elementAt(index).neighborhood,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: model.addressSelectedIndex == index
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ],
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
