import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_app/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() {
    return _EventsPageState();
  }
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: _buildBody(context),
      drawer: MenuDrawer(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('calendar').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final event = Events.fromSnapshot(data);
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final Map<String, dynamic> bookings = new Map();

    return Padding(
      key: ValueKey(event.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(event.image),
            child: Text(event.day.toString()),
          ),
          title: Text(event.name),
          trailing: GestureDetector(
            child: Icon(Icons.plus_one),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Scaffold(
                  appBar: AppBar(title: Text(event.name)),
                  body: Column(
                    children: <Widget>[
                      Container(
                          child: Image.network(
                        event.image,
                        fit: BoxFit.contain,
                      )),
                      Container(
                        child: Text(
                          "Register for this event:",
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      Container(
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.lightBlue.withOpacity(0.3),
                            hintText: "Email",
                          ),
                        ),
                      ),
                      Container(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.lightBlue.withOpacity(0.3),
                            hintText: "Full Name",
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              bookings.putIfAbsent("email",
                                  () => emailController.text.toString());
                              bookings.putIfAbsent(
                                  "name", () => nameController.text.toString());
                              Firestore.instance
                                  .collection('calendar')
                                  .document('match1')
                                  .collection('people')
                                  .add(bookings);
                              emailController.clear();
                              nameController.clear();
                              final scaffold = Scaffold.of(context);
                              scaffold.showSnackBar(SnackBar(
                                content:
                                    Text("You have registered for the event"),
                              ));
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  ),
                );
              }));
            },
          ),
        ),
      ),
    );
  }
}

class Events {
  final String name;
  final int day;
  final String image;
  final String month;
  int assisting;
  final DocumentReference reference;

  Events.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['day'] != null),
        assert(map['month'] != null),
        assert(map['assisting'] != null),
        assert(map['imgUrl'] != null),
        name = map['name'],
        day = map['day'],
        month = map['month'],
        image = map['imgUrl'],
        assisting = map['assisting'];

  Events.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
