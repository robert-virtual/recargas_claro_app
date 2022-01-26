import 'package:flutter/material.dart';

import 'package:recargas_claro_app/pages/simple_menu.dart';
import 'package:recargas_claro_app/routed_app.dart';
import 'package:recargas_claro_app/themes.dart';

void main() => runApp(const RoutedApp());



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Recargas App',
      home: const SimpleMenu()
    );
  }
}

