import 'package:catatudo_app/ui/widgets/collections_page/accept_collect_list.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:flutter/material.dart';

class ColectorCollectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[50],
        child: Column(
          children: <Widget>[
            DefaultAppBar(
              title: 'Coletas em Aberto',
              subTitle: 'Coletas aguardando o coletor',
            ),
            Expanded(
              child: ColectorCollectList(),
            ),
          ],
        ),
      ),
    );
  }
}
