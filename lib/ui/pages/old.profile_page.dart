import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/pages/edit_profile_page.dart';
import 'package:catatudo_app/ui/widgets/profile_page/list_user_address.dart';
import 'package:catatudo_app/ui/widgets/profile_page/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<UserModel>(context).user;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Perfil do usuario'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit_attributes),
                tooltip: 'editar perfil',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          // SliverPersistentHeader(
          //   delegate: UserSettingsHeader(maxExtend: 250, user: user),
          // ),
          SliverFixedExtentList(
            itemExtent: 160,
            delegate: SliverChildListDelegate(
              [
                _sliverBody(context),
              ],
            ),
          ),
          (user.addresses != null)
              ? ListUserAddress()
              : SliverFillRemaining(
                  fillOverscroll: false,
                  hasScrollBody: false,
                  child: Center(
                    child: _noAdressesCard(),
                  ),
                ),
          SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: false,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _sliverBody(context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                size: 14,
                color: Colors.green[900],
              ),
              SizedBox(width: 10),
              Text(
                user.email,
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.date_range,
                size: 14,
                color: Colors.green[900],
              ),
              SizedBox(width: 10),
              Text(
                "Reciclando desde maio de 2020",
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Endereços de Coleta',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              IconButton(
                  iconSize: 40,
                  color: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.add_box,
                    semanticLabel: 'Adicionar endereço',
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.ADD_ADDRESS_PAGE);
                  }),
            ],
          ),
        ],
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Column(
    //     children: <Widget>[
    //       Text(
    //         'Endereços de Coleta',
    //         style: TextStyle(
    //           color: Theme.of(context).primaryColor,
    //           fontSize: 26,
    //           fontWeight: FontWeight.bold,
    //           letterSpacing: 1.0,
    //         ),
    //       ),
    //       Container(
    //         height: 400,
    //         width: double.infinity,
    //         child: UserAddress(addresses: widget.user.addresses),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _noAdressesCard() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 10,
          child: Icon(
            FontAwesomeIcons.mapMarkedAlt,
            color: Colors.green.withOpacity(0.5),
            size: 80,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nenhum endereço cadastrado',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
