import 'package:catatudo_app/models/feed.dart';
import 'package:catatudo_app/screens/feed.dart';
import 'package:flutter/material.dart';

class FeedCarosel extends StatelessWidget {
  final List articles = _geraDadosFeed();

  List<Feed> feeds = new List<Feed>();
  FeedCarosel() {
    articles.forEach((article) => feeds.add(Feed.fromJson(article)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              // shadows: <Shadow>[
              //   Shadow(
              //     offset: Offset(0.5, 0.5),
              //     blurRadius: 3.0,
              //     color: Colors.black54,
              //   ),
              // ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Container(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: feeds.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedScreen(feed: feeds[index]),
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
                          Hero(
                            tag: feeds[index].image,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                height: 180,
                                width: double.infinity,
                                image: NetworkImage(feeds[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Container(
                              width: 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    feeds[index].title,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  Text(
                                    feeds[index].subtitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
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
          ),
        ),
      ],
    );
  }
}

_geraDadosFeed() {
  var results = [
    {
      "id": "1321321",
      "title": "Descarte Corretamente",
      "subtitle": "Apreenda descarta o lixo corretamente",
      "body":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et congue elit. Vestibulum euismod aliquet tristique. Sed eu porta nulla. Cras imperdiet tristique viverra. Suspendisse gravida odio ac malesuada mattis. Nam venenatis leo consequat varius mollis. Aliquam ut ante vitae justo tincidunt fermentum vel a ipsum. Praesent porta vel metus in iaculis. Fusce dignissim convallis dui quis aliquet. Integer efficitur massa lacus, vel feugiat mauris lobortis sed. Nunc mi neque, tempor ullamcorper nunc vitae, ultrices tempor ex. Mauris venenatis orci lobortis nisl consequat ullamcorper. Nunc in mi mi. Aliquam vitae ligula vestibulum, maximus tellus eu, placerat libero.",
      "image":
          "https://www.estudokids.com.br/wp-content/uploads/2019/04/reciclagem-o-que-e-importancia-1200x675.jpg"
    },
    {
      "id": "1321321",
      "title": "Dicas de Discart",
      "subtitle": "Separando o lixo da maneira correta",
      "body":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et congue elit. Vestibulum euismod aliquet tristique. Sed eu porta nulla. Cras imperdiet tristique viverra. Suspendisse gravida odio ac malesuada mattis. Nam venenatis leo consequat varius mollis. Aliquam ut ante vitae justo tincidunt fermentum vel a ipsum. Praesent porta vel metus in iaculis. Fusce dignissim convallis dui quis aliquet. Integer efficitur massa lacus, vel feugiat mauris lobortis sed. Nunc mi neque, tempor ullamcorper nunc vitae, ultrices tempor ex. Mauris venenatis orci lobortis nisl consequat ullamcorper. Nunc in mi mi. Aliquam vitae ligula vestibulum, maximus tellus eu, placerat libero.",
      "image":
          "https://static.vix.com/pt/sites/default/files/r/reciclagem-lixo-materiais-1019-1400x800.jpg"
    },
    {
      "id": "1321321",
      "title": "Voce descarta corretamente?",
      "subtitle": "Faça o teste e decubra se você descarta o lixo corretamente",
      "body":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et congue elit. Vestibulum euismod aliquet tristique. Sed eu porta nulla. Cras imperdiet tristique viverra. Suspendisse gravida odio ac malesuada mattis. Nam venenatis leo consequat varius mollis. Aliquam ut ante vitae justo tincidunt fermentum vel a ipsum. Praesent porta vel metus in iaculis. Fusce dignissim convallis dui quis aliquet. Integer efficitur massa lacus, vel feugiat mauris lobortis sed. Nunc mi neque, tempor ullamcorper nunc vitae, ultrices tempor ex. Mauris venenatis orci lobortis nisl consequat ullamcorper. Nunc in mi mi. Aliquam vitae ligula vestibulum, maximus tellus eu, placerat libero.",
      "image":
          "https://blog.brkambiental.com.br/wp-content/uploads/2019/07/original-b742306ee3cd42b3c57b1a4b986bcb0c.jpg"
    }
  ];
  return results;
}
