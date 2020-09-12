import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<UserModel>(context).user;

    String typeProfile = (user.isCollector) ? "Coletor" : "Gerador";
    //  user.createdDate

    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: 200,
            width: 200,
            child: CircleAvatar(
              backgroundImage: user.image == null
                  ? AssetImage('assets/images/user_profile.png')
                  : NetworkImage(user.image),
            ),
          ),
          SizedBox(height: 10),
          Text(
            typeProfile,
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w400,
            ),
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.date_range,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                "Reciclando desde " +
                    DateFormat.yMMMM('pt_BR')
                        .format(DateTime.parse(user.createdDate)),
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.email,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          user.phone != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      user.phone,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                )
              : SizedBox(height: 20),
          SizedBox(height: 40),
          OutlineButton.icon(
            label: new Text('Editar Perfil'),
            icon: Icon(Icons.edit),
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor,
            highlightedBorderColor: Colors.green,
            borderSide: new BorderSide(color: Theme.of(context).primaryColor),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.EDIT_PROFILE_PAGE);
            },
          ),
        ],
      ),
    );
  }
}
