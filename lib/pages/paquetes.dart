import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:recargas_claro_app/models/recarga.dart';
import 'package:recargas_claro_app/providers/recargas_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaquetesPage extends StatefulWidget {
  PaquetesPage({Key? key}) : super(key: key);

  @override
  _PaquetesPageState createState() => _PaquetesPageState();
}

class _PaquetesPageState extends State<PaquetesPage> {
  late Map<String, List<Recarga>> recargas;
  final telefono = TextEditingController();
  final pinController = TextEditingController();
  String mostrando = "Ilimitados";
  bool inicializado = false;
  Recarga?
      selecioada; //Recarga(cod: "cod", price: 20, title: "title", description: "description", duration: "duration");
  @override
  void initState() {
    super.initState();
    obtenerRecargas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.blue,
        title: const Text("Paquetes"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: inicializado == false
              ? const Text("")
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Wrap(
                      spacing: 4.0,
                      children: List.generate(
                          recargas.length,
                          (i) => ChoiceChip(
                                label: Text(recargas.keys.elementAt(i)),
                                selected:
                                    mostrando == recargas.keys.elementAt(i),
                                onSelected: (bool seleteed) {
                                  setState(() {
                                    selecioada = null;
                                    mostrando = recargas.keys.elementAt(i);
                                  });
                                },
                              )),
                    )
                  ]),
                ),
        ),
      ),
      body: selecioada != null
          ? Center(
              child: item(recarga: selecioada!, close: true),
            )
          : inicializado == true
              ? ListView.builder(
                  itemCount: recargas[mostrando]!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selecioada = recargas[mostrando]![i];
                        });
                      },
                      child: item(recarga: recargas[mostrando]![i]),
                    );
                  })
              : const Center(
                  child: Text("Cargando..."),
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
      ),
    );
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

    // final cadena = "*135*${telefono.text}*${selecioada!.cod}*$pin#";
    FlutterPhoneDirectCaller.callNumber(telefono.text);
  }

  obtenerRecargas() async {
    recargas = await recargasProvider.cargarDatos();
    setState(() {
      inicializado = true;
    });
  }

  Widget item({required Recarga recarga, bool close = false}) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recarga.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Visibility(
                  visible: close,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          selecioada = null;
                        });
                      },
                      icon: Icon(Icons.close)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              recarga.description,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recarga.duration,
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  "Lps. ${recarga.price}",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
