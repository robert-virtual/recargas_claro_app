import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/ajustes.dart';
import 'package:recargas_claro_app/pages/paquetes.dart';
import 'package:recargas_claro_app/pages/recargas.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      debugShowCheckedModeBanner: false,
      title: 'Recargas App',
      home: DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Recargas App"),
            bottom: const TabBar(
              tabs:[
                Tab(
                  text: "Recargas",
                ),
                Tab(
                  text: "Paquetes",
                ),
                Tab(
                  text: "Ajustes",
                )
              ] 
            ),
          ),
          body: TabBarView(
            children: [
            RecargasPage(),
            PaquetesPage(),
            const AjustePages()
          ],),
        )
      )
    );
  }
}

