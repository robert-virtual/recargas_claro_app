import 'package:flutter/material.dart';

class RecargasPage extends StatefulWidget {
  RecargasPage({Key? key}) : super(key: key);

  @override
  _RecargasPageState createState() => _RecargasPageState();
}

class _RecargasPageState extends State<RecargasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recargas"),
      ),
    );
  }
}
