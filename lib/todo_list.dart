import 'package:flutter/material.dart';
import 'package:modal_dilog/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = []; //we can use class Todo
  TextEditingController controller =
      TextEditingController(); //get value from textfield(ceclare object)
  //Toggle todo
  todoDone(Todo todo, bool isChecked) {
    //instance(kert chinh pi class) to access to use all property in class Todo
    setState(() {
      todo.isDone = isChecked; //access to class Todo(store true when we check)
    });
  }

// Add Todo for Todo list
  addTodo() async {
    //seen data
    final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New Todo"),
            content: TextField(
              controller: controller, //get value from textfield
              autofocus: true, //we can write text it have mouns auto
              decoration: new InputDecoration(
                hintText: "Add new....",
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Add"),
                onPressed: () {
                  setState(() {
                    var todo = Todo(title: controller.value.text); //get value from textfield
                    if (controller.value.text == "") {
                      print("");
                    } else {
                      todos.add(todo);
                    }
                    controller.clear();
                    Navigator.of(context).pop(todo);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          //context = build context to screen
          final listTodo = todos[index]; // can not change value
          return CheckboxListTile(
            value: listTodo.isDone,
            title: Text(listTodo.title),
            onChanged: (bool isCheckeds) {
              //store true(it will store true or false when we check)
              todoDone(listTodo, isCheckeds); // give vaule to todoDone
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addTodo,
      ),
    );
  }
}
