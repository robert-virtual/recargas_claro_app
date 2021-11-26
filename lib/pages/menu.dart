import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
            
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.power),
            label: "Recargas"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_callback),
            label: "Paquetes"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Ajustes"
          )
        ]
      ),
    );
  }
} 