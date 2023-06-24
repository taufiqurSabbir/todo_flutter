import 'package:flutter/material.dart';
import 'package:todo_2/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo App',
      home: HomeScreen(),
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
