import 'package:flutter/material.dart';
import 'dart:async';


class DetailsPage extends StatelessWidget {
   // Declare a field that holds the Todo.
  final  todo;

  // In the constructor, require a Todo.
  DetailsPage({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Container(
    padding: EdgeInsets.all(10),
    child: Center(
        child: Text(
          todo
          )
    )
),
    );
  }
}