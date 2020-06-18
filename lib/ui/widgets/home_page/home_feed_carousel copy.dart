import 'package:catatudo_app/core/models/feed.dart';
import 'package:catatudo_app/core/viewModel/feed_model.dart';
import 'package:catatudo_app/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class FeedCarosel extends StatefulWidget {
//   const FeedCarosel({Key key}) : super(key: key);
//   @override
//   _FeedCaroselState createState() => _FeedCaroselState();
// }

// class _FeedCaroselState extends State<FeedCarosel> {
//   @override
//   void initState() {
//     FeedModel model = FeedModel(api: Provider.of(context));

//     model.getFeeds();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<FeedModel>(
//       create: (_) => FeedModel(api: Provider.of(context)),
//       child: Consumer<FeedModel>(
//         builder: (context, model, child) => Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
//                 child: Text(
//                   'Dicas e Novidades',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     // color: Colors.green[900],
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.0,
//                     // shadows: <Shadow>[
//                     //   Shadow(
//                     //     offset: Offset(0.5, 0.5),
//                     //     blurRadius: 3.0,
//                     //     color: Colors.black54,
//                     //   ),
//                     // ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
//                 child: Container(
//                   height: 300,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: model.feeds.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   FeedScreen(feed: model.feeds[index]),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   blurRadius: 6.0,
//                                   offset: Offset(0.0, 2.0),
//                                 ),
//                               ],
//                             ),
//                             height: 200,
//                             width: 220,
//                             child: Stack(
//                               children: <Widget>[
//                                 Hero(
//                                   tag: model.feeds[index].image,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                     child: Image(
//                                       height: 180,
//                                       width: double.infinity,
//                                       image: NetworkImage(
//                                           model.feeds[index].image),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   left: 10,
//                                   bottom: 10,
//                                   child: Container(
//                                     width: 190,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(
//                                           model.feeds[index].title,
//                                           style: TextStyle(
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.bold,
//                                             letterSpacing: 1.0,
//                                           ),
//                                         ),
//                                         Text(
//                                           model.feeds[index].subtitle,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class FeedCarosel extends StatelessWidget {
  const FeedCarosel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostsModel>(
        model: PostsModel(api: Provider.of(context)),
        onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
        builder: (context, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.posts.length,
                itemBuilder: (context, index) => PostListItem(
                  post: model.posts[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.Post,
                      arguments: model.posts[index],
                    );
                  },
                ),
              ));
  }
}
