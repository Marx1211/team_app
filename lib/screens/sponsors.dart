import 'package:flutter/material.dart';
import 'package:team_app/widgets/menu_drawer.dart';

class SponsorsPage extends StatefulWidget {
  static final routeName = "/news";

  @override
  SponsorsPageState createState() => SponsorsPageState();
}

class SponsorsPageState extends State<SponsorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsors"),
      ),
      body: Column(
        children: <Widget>[
          _createSponsor("Fake 1", "assets/logos/fakelogo1.jpg",
              "This is fake company number 1"),
          _createSponsor("Fake 2", "assets/logos/fakelogo2.jpg",
              "This is fake company number 2"),
          _createSponsor("Fake 3", "assets/logos/fakelogo3.jpeg",
              "This is fake company number 3")
        ],
      ),
      drawer: MenuDrawer(),
    );
  }

  _createSponsor(String name, String logoLoc, String description) {
    return Expanded(
        child: GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 30.0),
          leading: CircleAvatar(
            backgroundImage: AssetImage(logoLoc),
            radius: 60,
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: 24.0),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Scaffold(
              appBar: AppBar(title: Text(name)),
              body: Column(
                children: <Widget>[
                  Container(
                      child: Image.asset(
                    logoLoc,
                    fit: BoxFit.contain,
                  )),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            );
          })),
    ));
  }
}
