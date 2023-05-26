import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/ajustes.dart';
import 'package:recargas_claro_app/pages/paquetes.dart';
import 'package:recargas_claro_app/pages/recargas.dart';

class TabsMenu extends StatefulWidget {
  const TabsMenu({Key? key}) : super(key: key);

  @override
  State<TabsMenu> createState() => _TabsMenuState();
}

class _TabsMenuState extends State<TabsMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Recargas/Paquetes Claro"),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Recargas",
              ),
              Tab(
                text: "Paquetes",
              ),
              Tab(
                text: "Ajustes",
              )
            ]),
          ),
          body: const TabBarView(
            children: [RecargasPage(), PaquetesPage(), AjustePages()],
          ),
        ));
  }
}
