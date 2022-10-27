import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[400],
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('abc'),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: const Text('new'),
          ),
        ),
      ),
    );
  }
}
