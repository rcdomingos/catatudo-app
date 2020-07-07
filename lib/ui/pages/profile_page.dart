import 'package:catatudo_app/core/constants/app_route.dart';
import 'package:catatudo_app/core/models/user.dart';
import 'package:catatudo_app/core/viewModel/user_profile_model.dart';
import 'package:catatudo_app/ui/pages/edit_profile_page.dart';
import 'package:catatudo_app/ui/widgets/profile_page/list_user_address.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  User user;

  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<UserModel>(context).user;

    // String typeProfile = (user.isCollector) ? "Coletor" : "Gerador";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: SliverCustomHeaderDelegate(
                  coverImgUrl: user.image,
                  expandedHeight: 300,
                  paddingTop: 0.0,
                  title: user.name),
            ),
            SliverFixedExtentList(
              itemExtent: 100,
              delegate: SliverChildListDelegate(
                [
                  _sliverBody(context),
                ],
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                    iconSize: 40,
                    color: Theme.of(context).primaryColor,
                    icon: Icon(
                      Icons.add_box,
                      semanticLabel: 'Adicionar endereço',
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.ADD_ADDRESS_PAGE);
                    }),
              ],
              title: Text(
                'Endereços da coleta',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              pinned: true,
            ),
            (user.addresses != null)
                ? ListUserAddress()
                : SliverFillRemaining(
                    child: Center(
                      child: _noAdressesCard(),
                    ),
                  ),
            SliverFillRemaining(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noAdressesCard() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 10,
          child: Icon(
            FontAwesomeIcons.mapMarkedAlt,
            color: Colors.green.withOpacity(0.5),
            size: 80,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nenhum endereço cadastrado',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sliverBody(context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                size: 14,
                color: Colors.green[900],
              ),
              SizedBox(width: 10),
              Text(
                user.email,
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.date_range,
                size: 14,
                color: Colors.green[900],
              ),
              SizedBox(width: 10),
              Text(
                "Reciclando desde maio de 2020",
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
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

  final double collapsedHeight = 90.0;

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

          Container(
            margin: EdgeInsets.only(bottom: 45.0),
            child: (this.coverImgUrl == null)
                ? Icon(Icons.person)
                : Image.network(this.coverImgUrl, fit: BoxFit.cover),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              color: this.makeStickyHeaderTextColor(
                                  shrinkOffset, true),
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: this.makeStickyHeaderTextColor(
                                  shrinkOffset, true), // Share icon color
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
