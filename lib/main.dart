import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/menu.dart';
import 'package:recargas_claro_app/pages/tabs.dart';

void main() => runApp(MyAppWithTabs());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recargas App',
      home: Menu(),
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
    );
  }
}