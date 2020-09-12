import 'package:catatudo_app/core/models/feed.dart';
import 'package:catatudo_app/ui/widgets/shared/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatelessWidget {
  final Feed feed;

  const FeedPage({Key key, this.feed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            DefaultAppBar(
              title: feed.tag == null ? 'Novidades' : feed.tag,
              subTitle: 'Ajudando você a saber mais',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      feed.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        // color: Colors.green[900],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: NetworkImage(feed.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      feed.subtitle,
                      style: TextStyle(
                        color: Colors.grey,
                        // color: Colors.green[900],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      DateFormat.yMMMMd('pt_BR')
                          .format(DateTime.parse(feed.createdDate)),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      feed.body,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'FONTE: ' + feed.source,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Gostou? Então visite nosso site para saber mais!   =)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
