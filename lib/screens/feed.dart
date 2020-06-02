import 'package:catatudo_app/models/feed.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  final Feed feed;
  FeedScreen({this.feed});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: widget.feed.image,
                child: Image(
                  image: NetworkImage(widget.feed.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: <Widget>[
                Text(
                  widget.feed.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.green[900],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.feed.body,
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
