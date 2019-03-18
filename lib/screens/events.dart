import 'package:flutter/material.dart';
import 'package:team_app/widgets/menu_drawer.dart';


class EventsPage extends StatefulWidget {
  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          top,
          events,
        ],
      ),
      drawer: MenuDrawer(),
    );
  }
  Widget get top => Container(
    height: 100.0,
    padding: EdgeInsets.only(bottom: 15.0),
    color: Colors.yellow[300],
  );
  Widget get events => Expanded(
    child: Container(
      child: Text("Events"),
      color: Colors.blue[300],
    ),
  );
}