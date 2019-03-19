import 'package:flutter/material.dart';
import 'package:team_app/screens/news.dart';
import 'package:team_app/screens/events.dart';
import 'package:team_app/screens/gallery.dart';
import 'package:team_app/screens/sponsors.dart';

enum Pages { news, events, gallery, sponsors, login }

var _current = Pages.news;

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          DrawerHeader(
              child: Container(
                child: Text("Team app"),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/friends.jpg"),
                      fit: BoxFit.cover))),
          new ListTile(
            trailing: new Icon(Icons.arrow_forward_ios),
            title: new Text("News"),
            selected: _current == Pages.news,
            onTap: () => _onPageTap(context, Pages.news),
          ),
          new ListTile(
            trailing: new Icon(Icons.arrow_forward_ios),
            title: new Text("Events"),
            selected: _current == Pages.events,
            onTap: () => _onPageTap(context, Pages.events),
          ),
          new ListTile(
            trailing: new Icon(Icons.arrow_forward_ios),
            title: new Text("Gallery"),
            selected: _current == Pages.gallery,
            onTap: () => _onPageTap(context, Pages.gallery),
          ),
          new ListTile(
            trailing: new Icon(Icons.arrow_forward_ios),
            title: new Text("Sponsors"),
            selected: _current == Pages.sponsors,
            onTap: () => _onPageTap(context, Pages.sponsors),
          ),
        ],
      ),
    );
  }

  _onPageTap(BuildContext context, var changeCurrent) {
    setState(() {
      _current = changeCurrent;
    });
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      switch (changeCurrent) {
        case Pages.news:
          return new NewsPage();
        case Pages.events:
          return new EventsPage();
        case Pages.gallery:
          return new GalleryPage();
        case Pages.sponsors:
          return new SponsorsPage();
        default:
          return new NewsPage();
      }
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return new FadeTransition(
        opacity: animation,
        child: child,
      );
    }));
  }
}
