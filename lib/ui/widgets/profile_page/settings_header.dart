import 'dart:math';

import 'package:catatudo_app/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserSettingsHeader implements SliverPersistentHeaderDelegate {
  final double maxExtend;
  final User user;

  UserSettingsHeader({@required this.maxExtend, this.user});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    String tipoPerfil = (user.isCollector) ? "Coletor" : "Gerador";
    double minImage = (shrinkOffset < 180) ? shrinkOffset : 180;

    // print(shrinkOffset);
    // print(tamanhoImage);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          top: 10,
          child: Container(
            width: 180 - minImage,
            height: 180 - minImage,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
              borderRadius: BorderRadius.circular(180),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(180),
              child: Image(
                image: NetworkImage(user.image),
              ),
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tipoPerfil,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
                ),
              ),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
                ),
              ),
            ],
          ),
        ),
        // Image(
        //   image: NetworkImage(
        //     user.image,
        //   ),
        // ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => this.maxExtend;

  @override
  // TODO: implement minExtent
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
