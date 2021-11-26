import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjustePages extends StatefulWidget {
  const AjustePages({Key? key}) : super(key: key);

  @override
  _AjustePagesState createState() => _AjustePagesState();
}

class _AjustePagesState extends State<AjustePages> {
  final pin = TextEditingController();
  String pinguardado = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarpin();
  }

  void cargarpin() async {
    final pref = await SharedPreferences.getInstance();
    pin.text = pref.getString("pin") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
      ),
      body: Column(
        children: [
          Text(pin.text),
          TextField(
            decoration: InputDecoration(hintText: "Ingrese su Pin."),
            controller: pin,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pref = await SharedPreferences.getInstance();
          pref.setString("pin", pin.text);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
