import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/services/api.dart';
import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_address.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_app_bar.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_date.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_resume.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_return_page.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_time.dart';
import 'package:catatudo_app/ui/widgets/collect_page/collect_type.dart';
import 'package:catatudo_app/ui/widgets/shared/default_button.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';
import 'package:catatudo_app/ui/widgets/widget_base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    CollectTime(),
    CollectResume(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddCollectModel>(
      model: AddCollectModel(api: Provider.of<Api>(context)),
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              CollectAppBar(),
              Visibility(
                visible: !model.busy,
                child: Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _collectPages.length,
                    onPageChanged: model.setButtonConfirmar,
                    itemBuilder: (BuildContext context, int index) {
                      return _collectPages[index % _collectPages.length];
                    },
                  ),
                ),
                replacement: Expanded(
                  child: Loading(
                    texto: 'Aguarde, Gerando a coleta...',
                  ),
                ),
              ),
              model.confirmar
                  ? DefaultButton(
                      texto: 'Enviar Coleta',
                      onPressed: (model.collect.collectTime == null ||
                              model.collect.collectDate == null ||
                              model.collect.address == null ||
                              model.collect.collectType == null)
                          ? null
                          : () {
                              model.enviarColeta().then((result) {
                                if (result) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReturnCollectPage(
                                              type: true,
                                              message: 'Coleta Agendada',
                                            )),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReturnCollectPage(
                                            type: false,
                                            message:
                                                'Não foi possivel realizar a coleta')),
                                  );
                                }
                              });
                            })
                  : DefaultButton(
                      texto: 'Continuar',
                      onPressed: () {
                        _pageController.nextPage(
                            duration: _duration, curve: _curve);
                      })
            ],
          ),
        ),
      ),
    );
  }
}
