import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/address.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListUserAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, model, child) => ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount:
            model.user.addresses == null ? 0 : model.user.addresses.length,
        itemBuilder: (context, index) {
          return _itemAdress(context, model.user.addresses[index]);
        },
      ),
    );
  }

  Widget _itemAdress(context, Address address) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.mapMarkedAlt,
        color: Colors.green.withOpacity(0.5),
        size: 30,
      ),
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
          Navigator.pushNamed(context, AppRoute.EDIT_ADDRESS_PAGE,
              arguments: address);
        },
      ),
    );
  }
}
