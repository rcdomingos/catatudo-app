import 'package:catatudo_app/core/viewModel/feed_model.dart';
import 'package:catatudo_app/ui/pages/feed_page.dart';
import 'package:catatudo_app/ui/widgets/shared/widget_loading.dart';
import 'package:catatudo_app/ui/widgets/widget_base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedCarosel extends StatelessWidget {
  const FeedCarosel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FeedModel>(
      model: FeedModel(api: Provider.of(context)),
      onModelReady: (model) => model.getFeeds(),
      builder: (context, model, child) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
              child: Text(
                'Dicas e Novidades',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  // color: Colors.green[900],
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Container(
                height: 250,
                child: Visibility(
                  visible: !model.busy,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (model.feeds != null) ? model.feeds.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FeedPage(feed: model.feeds[index]),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 2.0),
                                ),
                              ],
                            ),
                            height: 200,
                            width: 220,
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/load.gif',
                                    height: double.infinity,
                                    // width: double.infinity,
                                    image: model.feeds[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                tagContainer(model.feeds[index].tag == null
                                    ? 'Novidades'
                                    : model.feeds[index].tag),
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Container(
                                    width: 190,
                                    child: Text(
                                      model.feeds[index].title,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                        background: Paint()
                                          ..color = Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  replacement: Loading(texto: 'Carregano as novidades'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Tag dos feeds
  Widget tagContainer(String tag) {
    Color bodyColor;
    Color textColor;
    switch (tag.toLowerCase()) {
      case 'novidades':
        {
          bodyColor = Colors.amber;
          textColor = Colors.black;
        }
        break;

      case 'dicas':
        {
          bodyColor = Colors.green;
          textColor = Colors.white;
        }
        break;

      case 'noticias':
        {
          bodyColor = Colors.red[400];
          textColor = Colors.white;
        }
        break;

      default:
        {
          bodyColor = Colors.white;
          textColor = Colors.black;
        }
        break;
    }

    return Container(
      alignment: Alignment.center,
      width: 75,
      height: 20,
      decoration: BoxDecoration(
        color: bodyColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0)),
      ),
      child: Text(
        tag,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
