import 'package:catatudo_app/core/models/feed.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  final Feed feed;

  const FeedPage({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
                coverImgUrl: feed.image,
                expandedHeight: 300,
                paddingTop: 0.0,
                title: feed.title),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(feed.subtitle),
                  SizedBox(height: 20.0),
                  Text(feed.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//classe do soliver persistent header
class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;

  SliverCustomHeaderDelegate({
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  final double collapsedHeight = 110.0;

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderShadow(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 50)
        .toInt();
    return Color.fromARGB(alpha, 85, 85, 85);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 77, 221, 41);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Hero(
            tag: this.coverImgUrl,
            child: Container(
              margin: EdgeInsets.only(bottom: 45.0),
              child: Image.network(this.coverImgUrl, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Container(
              height: 80,
              width: 150,
              alignment: Alignment.center,
              color: Colors.white24,
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: this.makeStickyHeaderBgColor(shrinkOffset),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(55),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: this.makeStickyHeaderBgColor(shrinkOffset),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(55),
                    ),
                    boxShadow: [
                      shrinkOffset <= this.collapsedHeight
                          ? BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                            )
                          : BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 0.5),
                              blurRadius: 6.0,
                            ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      IconButton(
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, true),
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Padding(
                        padding: EdgeInsets.only(left: 35, right: 20),
                        child: Text(
                          title,
                          style: TextStyle(
                              // color: Theme.of(context).primaryColor,
                              color: this.makeStickyHeaderTextColor(
                                  shrinkOffset, false),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
