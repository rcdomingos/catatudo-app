import 'package:catatudo_app/ui/pages/add_address_page.dart';
import 'package:catatudo_app/ui/pages/add_collect_page.dart';
import 'package:catatudo_app/ui/pages/collections_page.dart';
import 'package:catatudo_app/ui/pages/edit_address_page.dart';
import 'package:catatudo_app/ui/pages/home_page.dart';
import 'package:catatudo_app/ui/pages/login_page.dart';
import 'package:catatudo_app/ui/pages/profile_page.dart';
import 'package:catatudo_app/ui/pages/register_page.dart';
import 'package:catatudo_app/ui/pages/return_page.dart';
import 'package:catatudo_app/ui/pages/start_page.dart';
import 'package:catatudo_app/ui/provider_setup.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_route.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await GetStorage.init();
  initializeDateFormatting('pt_BR').then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'CataTudo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(77, 221, 41, 1),
          accentColor: Color.fromRGBO(21, 46, 41, 1),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Color.fromRGBO(77, 221, 41, 1),
          fontFamily: "Roboto",
          textTheme: TextTheme(
            bodyText1: TextStyle(fontFamily: "Roboto", fontSize: 16),
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.blue,
          ),
        ),

        // theme: ThemeData.dark(),
        initialRoute: AppRoute.START_PAGE,
        routes: {
          AppRoute.START_PAGE: (_) => StartPage(),
          AppRoute.HOME_PAGE: (_) => HomePage(),
          AppRoute.LOGIN_PAGE: (_) => LoginPage(),
          AppRoute.REGISTER_PAGE: (_) => RegisterPage(),
          AppRoute.RETURN_PAGE: (_) => ReturnPage(),
          AppRoute.PROFILE_PAGE: (_) => ProfilePage(),
          AppRoute.ADD_ADDRESS_PAGE: (_) => AddAddressPage(),
          AppRoute.EDIT_ADDRESS_PAGE: (_) => EditAddressPage(),
          AppRoute.ADD_COLLECT_PAGE: (_) => AddCollectPage(),
          AppRoute.COLLECTIONS_PAGE: (_) => CollectionsPage(),
        },
      ),
    );
  }
}
