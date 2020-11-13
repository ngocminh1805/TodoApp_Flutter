import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home());
  }
}

// home screen
class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  var todo = <String>[
    'todo 1',
    'todo 2',
    'todo 3',
    'todo 4',
    'todo 5',
  ];

  final myEdtController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myEdtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              //------------------------------ add to do container------------------------------------
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: 'Enter the To Do'),
                              style: TextStyle(fontSize: 18.0),
                              controller: myEdtController,
                            )),

                        //------------------ add to do button ---------------------------------------------
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    todo.add(myEdtController.text);
                                    myEdtController.clear();
                                  });
                                }))
                      ],
                    ),
                  )),

              // ---------------------------list to do ----------------------------------------------
              Expanded(
                  flex: 7,
                  child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        return TodoItem(todo[index], index);
                      }))
            ],
          ),
        )));
  }

  // --------------------todo Item------------------------------------------------
  Widget TodoItem(String title, int index) {
    return Container(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
            // --------------------- item edit button -----------------------------
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(Icons.edit),
                  // ------------- on press edut btn ----------------------
                  onPressed: null),
            ),
            // -----------------------item delete button ----------------------------
            Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(Icons.delete),
                    // ---------- on press delete btn --------
                    onPressed: () {
                      setState(() {
                        todo.removeAt(index);
                      });
                    }))
          ],
        ));
  }
}
