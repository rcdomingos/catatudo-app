import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/services/authentication.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/widgets/home_page/home_feed_carousel.dart';
import 'package:catatudo_app/ui/widgets/home_page/home_menu.dart';
import 'package:catatudo_app/ui/widgets/home_page/home_menu_coletor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserModel>(context).user;
    AuthenticationService auth = Provider.of<AuthenticationService>(context);

    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: <Widget>[
          //Card do Usuario
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            backgroundImage: user.image == null
                                ? AssetImage('assets/images/user_profile.png')
                                : NetworkImage(user.image),
                          ),
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushNamed(context, AppRoute.PROFILE_PAGE),
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.name,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Meu Perfil  ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    //
                                  ),
                                  Icon(
                                    Icons.settings,
                                    size: 14.0,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      auth.deleteLocalJwt();
                      Navigator.pushReplacementNamed(
                          context, AppRoute.START_PAGE);
                    },
                    alignment: Alignment.centerRight,
                    iconSize: 30.0,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          user.isCollector ? MenuHomeColetor() : MenuHomeScreen(),
          SizedBox(height: 10),
          FeedCarosel(),
        ],
      ),
    ));
  }
}
