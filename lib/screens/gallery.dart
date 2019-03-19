import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() {
    return _GalleryPageState();
  }
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: _buildBody(context),
      drawer: MenuDrawer(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('images').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final img = ImageURL.fromSnapshot(data);

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
                  style: TextStyle(color: Colors.white),
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  gradient: new LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.7),
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
