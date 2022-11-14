import 'package:flutter/material.dart';
import 'data.dart';

class favourite extends StatefulWidget {
  final List<dynamic> todos;
  const favourite({Key key, this.todos}) : super(key: key);

  @override
  State<favourite> createState() => _favouriteState(todos: todos);
}

class _favouriteState extends State<favourite> {
  List<dynamic> todos;
  _favouriteState({this.todos});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: InkWell(
                    onTap: () {},
                    child: makeListTile(todos[index], index),
                  ),
                ),
              );
            }));
  }

  makeListTile(Todo todo, index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      tileColor: Color(0xFF20DC1C),
      title: Row(
        children: [
          Text("${todo.idx}"),
        ],
      ),
    );
  }
}
