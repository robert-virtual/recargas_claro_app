import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:recargas_claro_app/models/venta.dart';
import 'package:recargas_claro_app/providers/ventas_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecargasPage extends StatefulWidget {
  RecargasPage({Key? key}) : super(key: key);

  @override
  _RecargasPageState createState() => _RecargasPageState();
}

class _RecargasPageState extends State<RecargasPage> {
  final pinController = TextEditingController();
  final telefono = TextEditingController();
  final cantidad = TextEditingController();
  List<String> common = List.generate(15, (i) => "${25 * (i + 1)}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 3,
                      onChanged: (value) {
                        setState(() {}); /*actualiza */
                      },
                      controller: cantidad,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Otra cantidad", counterText: ""),
                    ),
                  ),
                  InkWell(onTap: cantidad.clear, child: const Icon(Icons.close))
                ],
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
                                selected: common[i] == cantidad.text,
                                onSelected: (selected) {
                                  setState(() {
                                    cantidad.text = common[i];
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
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    child: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: enviarRecarga,
              child: const Icon(Icons.send),
            )
          ],
        ));
  }

  void enviarRecarga() async {
    if (telefono.text.isEmpty || cantidad.text.isEmpty) {
      const snackBar = SnackBar(content: Text("Uno o mas campos vacios"));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
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
                  const Text("Ingrese su pin"),
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

    final cadena = "*135*1*${telefono.text}*$cantidad*$pin#";
    await FlutterPhoneDirectCaller.callNumber(cadena);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Recargas"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Se envio la Recarga?"),
                Text("Monto: ${cantidad.text}"),
                Text("Telefono: ${telefono.text}"),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () async {
                    await ventasProvider.addVenta(Venta(
                        cliente: telefono.text,
                        descripcion: "Recarga",
                        monto: double.parse(cantidad.text)));

                    telefono.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Si"))
            ],
          );
        });
  }
}
