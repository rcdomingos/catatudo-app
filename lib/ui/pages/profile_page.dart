import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/ui/widgets/profile_page/list_user_address.dart';
import 'package:catatudo_app/ui/widgets/profile_page/user_info.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Icon(Icons.assignment_ind),
                text: 'informações',
              ),
              Tab(
                icon: Icon(Icons.map),
                text: 'endereços',
              )
            ],
          ),
          centerTitle: true,
          title: Text('Meu Perfil',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
        ),
        body: TabBarView(
          children: [
            /**Container com as informações do usuario */
            Container(
              child: UserInfo(),
            ),
            /**Container com os endereços do usuario */
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: ListUserAddress(),
                  ),
                  DefaultButton(
                    texto: 'Cadastrar Endereço',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.ADD_ADDRESS_PAGE);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// https://avatars1.githubusercontent.com/u/39439355?s=460&u=3b9182f05983670039cf991e6f7454697e5789d2&v=4
