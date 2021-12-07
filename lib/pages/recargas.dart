import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecargasPage extends StatefulWidget {
  RecargasPage({Key? key}) : super(key: key);

  @override
  _RecargasPageState createState() => _RecargasPageState();
}

class _RecargasPageState extends State<RecargasPage> {
  final pinController = TextEditingController();
  final telefono = TextEditingController();
  List<String> common = List.generate(15, (i) => "${25 * i}");
  String? cantidad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    cantidad = text;
                  });
                },
                decoration: InputDecoration(hintText: "Otra cantidad"),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                      spacing: 4.0,
                      children: List.generate(
                          common.length,
                          (i) => ChoiceChip(
                                label: Text(common[i]),
                                selected: common[i] == cantidad,
                                onSelected: (selected) {
                                  setState(() {
                                    cantidad = common[i];
                                  });
                                },
                              ))),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: TextField(
                      controller: telefono,
                      maxLength: 8,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Numero de telefono",
                        border: InputBorder.none,
                        counterText: "",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: telefono.clear,
                    child: Icon(Icons.close),
                  )
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: enviarRecarga,
              child: Icon(Icons.send),
            )
          ],
        ));
  }

  void enviarRecarga() async {
    // final
    final pref = await SharedPreferences.getInstance();
    String? pin = pref.getString('pin');

    if (pin == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Pin"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("ingrese su pin"),
                  TextField(
                    controller: pinController,
                    decoration: const InputDecoration(hintText: "pin"),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar")),
                TextButton(
                    onPressed: () {
                      pref.setString('pin', pinController.text);
                      pin = pinController.text;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Guardar")),
              ],
            );
          });
    }
    if (pin == null) {
      return;
    }

    final cadena = "*135*2*2*${telefono.text}*$cantidad*$pin#";
    await FlutterPhoneDirectCaller.callNumber(cadena);
  }
}
