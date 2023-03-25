import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:recargas_claro_app/models/recarga.dart';
import 'package:recargas_claro_app/models/venta.dart';
import 'package:recargas_claro_app/providers/recargas_provider.dart';
import 'package:recargas_claro_app/providers/ventas_provider.dart';
import 'package:recargas_claro_app/widgets/recarga_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaquetesPage extends StatefulWidget {
  const PaquetesPage({
    Key? key,
    this.appbar = false,
  }) : super(key: key);
  final bool appbar;

  @override
  _PaquetesPageState createState() => _PaquetesPageState();
}

class _PaquetesPageState extends State<PaquetesPage> {
  late Map<String, List<Recarga>> recargas;
  final telefono = TextEditingController();
  final pinController = TextEditingController();
  String mostrando = "Ilimitados";
  bool inicializado = false;
  //Recarga(cod: "cod", price: 20, title: "title", description: "description", duration: "duration");
  Recarga? selecioada;
  @override
  void initState() {
    super.initState();
    obtenerRecargas();
  }

  Widget cats() {
    return SingleChildScrollView(
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            try{
              final result = await InternetAddress.lookup("www.google.com");
              if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.remove("recargas");
                obtenerRecargas();
              }
            }on SocketException catch(_){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not internet connection")));
            }
          }, icon: const Icon(Icons.refresh))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        title: widget.appbar
            ? const Text("Paquetes")
            : inicializado == false
                ? null
                : cats(),
        bottom: !widget.appbar 
            ? null
            : inicializado == false
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: cats()
              ),
        
      ),
      body: selecioada != null
          ? Center(
              child: RecargaItem(
                recarga: selecioada!,
                close: true,
                onPressed: () {
                  setState(() {
                    selecioada = null;
                  });
                },
              ),
            )
          : inicializado == true
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  itemCount: recargas[mostrando]!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selecioada = recargas[mostrando]![i];
                        });
                      },
                      child: RecargaItem(recarga: recargas[mostrando]![i]),
                    );
                  })
              : const Center(
                  child: Text("Cargando..."),
                ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
          const SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: enviarRecarga,
            child: const Icon(Icons.send),
          )
        ],
      ),
    );
  }

  void showMensaje(String msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  void enviarRecarga() async {
    if (selecioada == null) {
      showMensaje("No ha seleccionado un paquete");
      return;
    }

    if (telefono.text.isEmpty) {
      showMensaje("No ha ingresado un numero de telefono");
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

    final cadena = "*135*${telefono.text}*${selecioada!.cod}*$pin#";
    await FlutterPhoneDirectCaller.callNumber(cadena);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Paquetes"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Se envio el paquete?"),
                Text("Monto: ${selecioada!.price}"),
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
                        descripcion: selecioada!.title,
                        monto: selecioada!.price.toDouble()));
                    telefono.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Si"))
            ],
          );
        });
  }

  obtenerRecargas() async {
    recargas = await recargasProvider.cargarDatos();
    setState(() {
      inicializado = true;
    });
  }
}
