import 'package:flutter/material.dart';


class SimpleMenu extends StatefulWidget {
  const SimpleMenu({Key? key}) : super(key: key);

  @override
  State<SimpleMenu> createState() => _SimpleMenuState();
}

class _SimpleMenuState extends State<SimpleMenu> {
  List<Map<String,dynamic>> pages =   [
    {"name": const Text("Recargas"),  "page":"/recargas" },
    {"name": const Text("Paquetes"),  "page":"/paquetes" },
    {"name": const Text("Pin"),       "page":"/pin" },
    {"name": const Text("Historial"), "page":"/historial" }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recargas App"),
      ),
      body: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, pages[i]["page"]);
                  },
                  title: pages[i]["name"],
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                const Divider()
              ],
            );
          }),
    );
  }
}
