import 'package:catatudo_app/ui/widgets/collections_page/collect_list.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:flutter/material.dart';

class CollectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            DefaultAppBar(
              title: 'Coletas Agendadas',
              subTitle: 'Consulte aqui seus agendamentos',
            ),
            Expanded(
              child: CollectList(),
            ),
          ],
        ),
      ),
    );
  }
}
