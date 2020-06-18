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
      builder: (context, model, child) => SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            child: _itemAdress(context, model.user.addresses[index]),
          );
        }, childCount: model.user.addresses.length),
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
          print(address);
          Navigator.pushNamed(context, AppRoute.EDIT_ADDRESS_PAGE,
              arguments: address);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => EditAddressScreen(address: address),
          //   ),
          // );
        },
      ),
    );
  }
}
