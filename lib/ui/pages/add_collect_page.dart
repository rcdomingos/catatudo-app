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
    Center(child: Text('Tipo de coleta')),
    Center(child: Text('Endereço da Coleta')),
    Center(child: Text('Data da Coleta')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _collectPages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _collectPages[index % _collectPages.length];
                },
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text('Prev'),
                    onPressed: () {
                      _pageController.previousPage(
                          duration: _duration, curve: _curve);
                    },
                  ),
                  FlatButton(
                    child: Text('Next'),
                    onPressed: () {
                      _pageController.nextPage(
                          duration: _duration, curve: _curve);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
