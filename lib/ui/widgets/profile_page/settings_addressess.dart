import 'package:catatudo_app/core/models/address.dart';
import 'package:flutter/material.dart';

class UserAddress extends StatelessWidget {
  List<Address> addresses;
  UserAddress({this.addresses});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (BuildContext context, int index) {
            return _itemAdress(this.addresses.elementAt(index));
          }),
    );
  }

  _itemAdress(Address address) {
    return ListTile(
      isThreeLine: true,
      title: Text(
        address.city,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(address.street + '\n' + address.neighborhood),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        color: Colors.green,
        onPressed: () {
          // Navigator.of(context).pushNamed();
        },
      ),
    );
  }
}
