import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_address.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_app_bar.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_date.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_type.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/widget_base_provider.dart';
import 'package:flutter/material.dart';

class AddCollectPage extends StatefulWidget {
  @override
  _AddCollectPageState createState() => _AddCollectPageState();
}

class _AddCollectPageState extends State<AddCollectPage> {
  final _pageController = new PageController();
  static const _duration = const Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  List<Widget> _collectPages = [
    CollectType(),
    CollectAddress(),
    CollectDate(),
    Center(child: Text('Confirmar a Coleta')),
  ];
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddCollectModel>(
      model: AddCollectModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              CollectAppBar(),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _collectPages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _collectPages[index % _collectPages.length];
                  },
                ),
              ),
              // Container(
              //   color: Theme.of(context).primaryColor,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              // FlatButton(
              //   child: Text('Prev'),
              //   onPressed: () {
              //     _pageController.previousPage(
              //         duration: _duration, curve: _curve);
              //   },
              // ),

              // FlatButton(
              //   child: Text('Next'),
              //   onPressed: () {
              //     _pageController.nextPage(
              //         duration: _duration, curve: _curve);
              //   },
              // )
              //     ],
              //   ),
              // ),
              DefaultButton(
                  texto: 'Continuar',
                  onPressed: () {
                    _pageController.nextPage(
                        duration: _duration, curve: _curve);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
