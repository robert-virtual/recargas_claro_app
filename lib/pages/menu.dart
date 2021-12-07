import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/ajustes.dart';
import 'package:recargas_claro_app/pages/paquetes.dart';
import 'package:recargas_claro_app/pages/recargas.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: paginaActual,
          children: [RecargasPage(), PaquetesPage(), AjustePages()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
          currentIndex: paginaActual,
          onTap: (index) {
            setState(() {
              paginaActual = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.power), label: "Recargas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone_callback), label: "Paquetes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Ajustes")
          ]),
    );
  }
}
