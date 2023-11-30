import 'package:flutter/material.dart';
import 'package:todo_db/pages/todo.dart';
import 'package:todo_db/pages/settings.dart';

void main() => runApp(MaterialApp(

  theme: ThemeData(
    primaryColor: Colors.white,
  ),
  initialRoute: '/todo',
  routes: {
    '/todo': (context) => Home(),
    '/settings': (context) => Settings(),
   },
  ),
);