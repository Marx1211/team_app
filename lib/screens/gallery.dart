import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

final imgUrls = [
  {
    "name": "image1",
    "url": "http://img-cdn.jg.jugem.jp/fb2/2094631/20120104_2709455.jpg"
  },
  {
    "name": "image2",
    "url": "http://img-cdn.jg.jugem.jp/fb2/2094631/20120104_2709455.jpg"
  },
  {
    "name": "image3",
    "url": "http://img-cdn.jg.jugem.jp/fb2/2094631/20120104_2709455.jpg"
  },
  {
    "name": "image4",
    "url": "http://img-cdn.jg.jugem.jp/fb2/2094631/20120104_2709455.jpg"
  },
];

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: _buildBody(context),
      drawer: MenuDrawer(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildList(context, imgUrls);
  }

  Widget _buildList(BuildContext context, List<Map> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Map data) {
    final img = ImageURL.fromMap(data);

    return Padding(
      key: ValueKey(img.name),
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(img.url), fit: BoxFit.cover)),
        child: GridTile(
          child: InkResponse(
            enableFeedback: true,
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Scaffold(
                    appBar: AppBar(title: Text(img.name)),
                    body: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.network(
                          img.url,
                          fit: BoxFit.contain,
                        ))
                      ],
                    ),
                  );
                })),
            child: Container(
                child: Text(
                  img.name,
                  textAlign: TextAlign.end,
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  gradient: new LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(1),
                      Colors.blueGrey.withOpacity(0.1)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.center,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class ImageURL {
  final String name;
  final String url;
  final DocumentReference reference;

  ImageURL.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['url'] != null),
        name = map['name'],
        url = map['url'];

  ImageURL.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$url>";
}
