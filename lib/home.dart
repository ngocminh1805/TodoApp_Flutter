import 'package:flutter/material.dart';

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

  final addTextController = TextEditingController();
  final editTextController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    addTextController.dispose();
    editTextController.dispose();
    super.dispose();
  }

  // -------------- show dialog ---------------------
  void openDialog(String title, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit To do'),
            content: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text("enter your change 'to do' in text field"),
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(hintText: title),
                    controller: editTextController,
                  ))
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  },
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      todo.removeAt(index);
                      todo.insert(index, editTextController.text);
                      editTextController.clear();
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  },
                  child: Text("Edit"))
            ],
          );
        });
  }

  // --------------- on delete to do item ----------------

  void onDelTodo(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete To Do'),
            content: Text("Do you want to delete " + todo[index]),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      todo.removeAt(index);
                    });
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  // --------------------- on add to do item ---------------------
  void onAddTodo(String text) {
    if (text.length > 0) {
      setState(() {
        if (text.length > 0) {}
        todo.add(addTextController.text);
        addTextController.clear();
      });
    }
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
                              controller: addTextController,
                            )),

                        //------------------ add to do button ---------------------------------------------
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                size: 30,
                              ),
                              onPressed: () =>
                                  onAddTodo(addTextController.text),
                            ))
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
                  onPressed: () => openDialog(title, index),
                )),
            // -----------------------item delete button ----------------------------
            Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(Icons.delete),
                    // ---------- on press delete btn --------
                    onPressed: () => onDelTodo(index)))
          ],
        ));
  }
}
