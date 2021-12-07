import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/ajustes.dart';
import 'package:recargas_claro_app/pages/paquetes.dart';
import 'package:recargas_claro_app/pages/recargas.dart';


class MyAppWithTabs extends StatelessWidget {
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
                  icon: Icon(Icons.power),
                ),
                Tab(
                  icon: Icon(Icons.phone),
                ),
                Tab(
                  icon: Icon(Icons.settings),
                )
              ] 
            ),
          ),
          body: TabBarView(children: [
            RecargasPage(),
            PaquetesPage(),
            const AjustePages()
          ],),
        )
      )
    );
  }
}