import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recargas App',
      home: Menu()
    );
  }
}