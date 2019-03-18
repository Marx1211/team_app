import 'package:flutter/material.dart';
import 'package:team_app/widgets/menu_drawer.dart';


class SponsorsPage extends StatefulWidget {
  static final routeName = "/news";
  @override
  SponsorsPageState createState() => SponsorsPageState();
}

class SponsorsPageState extends State<SponsorsPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          menu,
          news,
        ],
      ),
      drawer: MenuDrawer(),
    );
  }
  Widget get menu => Container(
    height: 100.0,
    padding: EdgeInsets.only(bottom: 15.0),
    color: Colors.yellow[300],
  );
  Widget get news => Expanded(
    child: Container(
      child: Text("Sponsors"),
      color: Colors.blue[300],
    ),
  );
}