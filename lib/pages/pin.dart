import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PinPage extends StatefulWidget {
  PinPage({Key? key}) : super(key: key);

  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
 final pin = TextEditingController();
  String pinguardado = "";
  @override
  void initState() {
    super.initState();
    cargarpin();
  }

  void cargarpin() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      pin.text = pref.getString("pin") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pin"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pin: " + pin.text,
            style: const TextStyle(fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: const InputDecoration(hintText: "Ingrese su Pin."),
              controller: pin,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:guardarPin,
        child: const Icon(Icons.save),
      ),
    );
  }

  void guardarPin() async {
     final pref = await SharedPreferences.getInstance();
      setState(() {
        pref.setString("pin", pin.text);
      });
      const snackBar =  SnackBar(content: Text("Pin Guardado"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}