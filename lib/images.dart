import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => new _ImagesState();
}

class _ImagesState extends State<Images> {
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
          title: Text("Images Page"),
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
                        child: Text("get images"), onPressed: () => getData())),
              )
            ],
          ),
        ));
  }
}

//--------------------------- list item ------------------------------------

Widget ImageItem(ApiImage img, int index) {
  return Container(
      height: 300,
      width: 600,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Image(
        image: NetworkImage(img.download_url),
      ));
}

String Url(String url, String id) {
  int index = url.indexOf(id);
  String str = url.substring(0, index);
  str = str + id + "/200";
  return str;
}

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
