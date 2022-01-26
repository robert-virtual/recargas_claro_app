import 'package:flutter/material.dart';
import 'package:recargas_claro_app/pages/historial.dart';
import 'package:recargas_claro_app/pages/pin.dart';

class AjustePages extends StatefulWidget {
  const AjustePages({Key? key,this.appbar = false}) : super(key: key);
  final bool appbar;

  @override
  _AjustePagesState createState() => _AjustePagesState();
}

class _AjustePagesState extends State<AjustePages> {
 

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appbar 
        ? AppBar(
          title: const Text("Ajustes"),
        )
        : null,
      body: Column(
        children: [
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              /*navefar a otra pagina*/
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HistorialPage()));
            },
            title: const Text("Historial"),
          ),
          const Divider(),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PinPage()));
            },
            title: const Text("Pin"),
          ),
          const Divider(),
          
        ],
      ),
     
    );
  }
}
