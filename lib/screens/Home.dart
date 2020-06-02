import 'dart:convert';
import 'package:catatudo_app/models/user.dart';
import 'package:catatudo_app/controller/userController.dart';
import 'package:catatudo_app/widgets/home_feed_carousel.dart';
import 'package:flutter/material.dart';
import 'package:catatudo_app/widgets/home_menu.dart';
import 'package:catatudo_app/screens/user_settings.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.jwt, this.payload);

  factory HomeScreen.fromBase64(String jwt) => HomeScreen(
        jwt,
        json.decode(
          ascii.decode(
            base64.decode(
              base64.normalize(jwt.split(".")[1]),
            ),
          ),
        ),
      );

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = new UserController();
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = controller.getInfoUser(widget.payload['user_id'], widget.jwt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) => snapshot.hasData
                ? HomeStart(snapshot.data)
                : snapshot.hasError
                    ? Text("An error occurred")
                    : CircularProgressIndicator()),
      ),
    );
  }

  Widget HomeStart(User user) {
    User userI = user;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Card do Usuario
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage(
                          "https://avatars2.githubusercontent.com/u/39439355?s=60&v=4"),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
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
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserSettingsScreen(),
                          ),
                        )
                      },
                      child: Row(
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          MenuHomeScreen(),
          FeedCarosel(),
        ],
      ),
    );
  }
}
