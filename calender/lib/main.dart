import 'package:calender/calender.dart';
import 'package:flutter/material.dart';

import 'calender2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TableComplexExample(),
    );
  }
}
