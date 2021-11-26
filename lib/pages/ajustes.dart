import 'package:flutter/material.dart';

class AjustePage extends StatefulWidget {
  const AjustePage({Key? key}) : super(key: key);

  @override
  _AjustePageState createState() => _AjustePageState();
}

class _AjustePageState extends State<AjustePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
      ),
    );
  }
}
