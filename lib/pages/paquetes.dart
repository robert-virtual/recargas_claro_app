import 'package:flutter/material.dart';
class PaquetesPage extends StatefulWidget {
  PaquetesPage({Key? key}) : super(key: key);

  @override
  _PaquetesPageState createState() => _PaquetesPageState();
}

class _PaquetesPageState extends State<PaquetesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paquetes"),
      ),
    );
  }
}