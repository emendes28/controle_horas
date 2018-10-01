import 'package:flutter/material.dart';
import 'ponto.dart';

void main() => runApp(MyApp());
const String title_app = 'Controle';
class MyApp extends StatelessWidget {
          
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: title_app,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrontPage(),
    );
  }
}