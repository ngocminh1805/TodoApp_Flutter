import 'package:flutter/material.dart';
import 'package:http/http.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => new _NewsState();
}

class _NewsState extends State<News> {
  var image = <Image>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News Page"),
        ),
        body: Center(
          child: Text("News Page"),
        ));
  }
}
