import 'package:catatudo_app/screens/Home.dart';
import 'package:catatudo_app/screens/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String jwt =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWVjZWM3YzI2NWY2MjcyODM4ODAwMjczIiwibmFtZSI6IlJlZ2luYWxkbyBDIiwiZW1haWwiOiJyY2RvbWluZ29zQGZhdGVjLmNvbSIsImlhdCI6MTU5MDYxNTcxOCwiZXhwIjoxNjIyMTUxNzE4fQ.iQYLD1WQR2J03b0gCIt2QqbCBvTV4KKbUO6_65NtHFQ";

    return MaterialApp(
        title: 'CataTudo App',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(77, 221, 41, 1),
          accentColor: Color.fromRGBO(21, 46, 41, 1),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Color.fromRGBO(77, 221, 41, 1),
          fontFamily: "Roboto",
          textTheme: TextTheme(
            bodyText1: TextStyle(fontFamily: "Roboto", fontSize: 16),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.blue,
          ),
        ),

        // theme: ThemeData.dark(),
        // home: StartPage(),
        home: HomeScreen.fromBase64(jwt));
  }
}
