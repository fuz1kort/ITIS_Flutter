import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/extra_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      routes: {'/extra': (context) => ExtraPage()},
    );
  }
}
