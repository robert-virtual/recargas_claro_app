import 'package:flutter/material.dart';

class AjustePages extends StatefulWidget {
  const AjustePages({Key? key}) : super(key: key);

  @override
  _AjustePagesState createState() => _AjustePagesState();
}

class _AjustePagesState extends State<AjustePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
      ),
    );
  }
}
