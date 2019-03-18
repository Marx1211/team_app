import 'package:flutter/material.dart';
import 'package:team_app/screens/news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home page',
      home: NewsPage(),
      routes: <String,WidgetBuilder>{
        NewsPage.routeName : (BuildContext context) => new NewsPage()
      },
    );

  }
}

