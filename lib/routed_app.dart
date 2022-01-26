import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/historial.dart';
import 'package:recargas_claro_app/pages/paquetes.dart';
import 'package:recargas_claro_app/pages/pin.dart';
import 'package:recargas_claro_app/pages/recargas.dart';
import 'package:recargas_claro_app/pages/simple_menu.dart';
class RoutedApp extends StatelessWidget {
  const RoutedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recargas App',
       theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: "/",
      routes: {
        "/":(context)=>const SimpleMenu(),
        "/recargas":(context)=>const RecargasPage(appbar: true,),
        "/paquetes":(context)=>const PaquetesPage(appbar: true,),
        "/pin":(context)=> const PinPage(),
        "/historial":(context)=>const HistorialPage(),
      },
    );
  }
}