import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  @override
  _NewsState createState() => new _NewsState();
}

class _NewsState extends State<News> {
  var image = <ApiImage>[];
  int page = 0;

  // ------------------------- read api and add data to array ------------------------------
  Future getData() async {
    final response = await http.get(
        'https://picsum.photos/v2/list?page=' + page.toString() + '&limit=50');
    print('RESPONSE' + response.body);
    // image.add(ApiImage.fromJson(jsonDecode(response.body)));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    final list =
        parsed.map<ApiImage>((json) => ApiImage.fromJson(json)).toList();

    setState(() {
      image.addAll(list);
      page++;
    });

    print('PARSE' + parsed.toString());
    print('LIST' + list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News Page"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: image.length,
                      itemBuilder: (context, index) {
                        return ImageItem(image[index], index);
                      })),
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(8),
                    width: 300,
                    child: RaisedButton(
                        child: Text("get data"), onPressed: () => getData())),
              )
            ],
          ),
        ));
  }
}

//--------------------------- list item ------------------------------------

Widget ImageItem(ApiImage img, int index) {
  return Container(
      height: 100,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      index.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      img.author,
                      style: TextStyle(fontSize: 10, color: Colors.green),
                    )),
                    Expanded(child: Text(img.url))
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Image(
                image: NetworkImage(Url(img.download_url, img.id)),
                height: 100,
                width: 100,
              ))
        ],
      ));
}

String Url(String url, String id) {
  int index = url.indexOf(id);
  String str = url.substring(0, index);
  str = str + id + "/200";
  return str;
}

// fecth api response
// Futuvore<ApiImage> fetchApiImage() async {
// Future<List<ApiImage>> fetchApiImage() async {
//   final response = await http.get('https://picsum.photos/v2/list');
//   print('RESPONSE from API: ' + response.body);

//    return ApiImage.fromJson(jsonDecode(response.body));
// }

// ------------------------------------define Class Api-------------------------------------------
class ApiImage {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String download_url;

  ApiImage(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.download_url});

  factory ApiImage.fromJson(Map<String, dynamic> json) {
    return ApiImage(
        id: json['id'],
        author: json['author'],
        width: json['width'],
        height: json['height'],
        url: json['url'],
        download_url: json['download_url']);
  }
}
