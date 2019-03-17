import 'package:flutter/material.dart';

enum Pages { news, events, gallery, sponsors, login }
var _current;
class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {

  void _handleTap(var changeCurrent) {
    setState(() {
      _current = changeCurrent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Container(child: Text("Team Application")),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/friends.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                ListTileTheme(
                  selectedColor: Colors.blue,
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("News"),
                    enabled: true,
                    selected: _current == Pages.news,
                    onTap: () {
                      Navigator.of(context).pop();
                      _handleTap(Pages.news);
                    },
                  ),
                ),
                ListTileTheme(
                  selectedColor: Colors.blue,
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Events"),
                    enabled: true,
                    selected: _current == Pages.events,
                    onTap: () {
                      _handleTap(Pages.events);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                ListTileTheme(
                  selectedColor: Colors.blue,
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Gallery"),
                    enabled: true,
                    selected: _current == Pages.gallery,
                    onTap: () {
                      Navigator.of(context).pop();
                      _handleTap(Pages.gallery);
                    },
                  ),
                ),
                ListTileTheme(
                  selectedColor: Colors.blue,
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Sponsors"),
                    enabled: true,
                    selected: _current == Pages.sponsors,
                    onTap: () {
                      Navigator.of(context).pop();
                      _handleTap(Pages.sponsors);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTileTheme(
                      selectedColor: Colors.blue,
                      child: ListTile(
                        leading: Icon(Icons.star),
                        title: Text("Team section"),
                        enabled: true,
                        selected: _current == Pages.login,
                        onTap: () {
                          Navigator.of(context).pop();
                          _handleTap(Pages.login);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
