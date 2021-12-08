import 'package:flutter/material.dart';
import 'package:recargas_claro_app/models/recarga.dart';
import 'package:recargas_claro_app/models/venta.dart';
import 'package:recargas_claro_app/providers/ventas_provider.dart';
import 'package:recargas_claro_app/widgets/recarga_item.dart';
import 'package:recargas_claro_app/widgets/search_historial.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({Key? key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  late Future<List<Venta>> ventas;
  List<String> categorias = ["hoy", "ayer", "anteayer", "todas"];
  String? categoria;
  @override
  void initState() {
    super.initState();
    getVentas();
  }

  void getVentas() async {
    ventas = ventasProvider.getVentas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: HistorialSearch(historial: ventas));
                },
                icon: const Icon(Icons.search))
          ],
          title: const Text("Historial de ventas"),
          bottom: PreferredSize(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Wrap(
                        spacing: 4.0,
                        children: categorias
                            .map(
                              (e) => ChoiceChip(
                                label: Text(e),
                                selected: categoria == e,
                                onSelected: (selected) {
                                  setState(() {
                                    categoria = e;
                                  });
                                },
                              ),
                            )
                            .toList())
                  ],
                ),
              ),
              preferredSize: const Size(100, 50)),
        ),
        body: FutureBuilder<List<Venta>>(
            future: ventas,
            builder: (context, snap) {
              if (snap.hasData) {
                switch (categoria) {
                  case "hoy":
                    final data = snap.data!
                        .where((v) => v.fecha.day == DateTime.now().day)
                        .toList();
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return RecargaItem(
                              recarga: Recarga.fromVenta(data[i]));
                        });
                  case "ayer":
                    final data = snap.data!
                        .where((v) => v.fecha.day == DateTime.now().day - 1)
                        .toList();
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return RecargaItem(
                              recarga: Recarga.fromVenta(data[i]));
                        });
                  case "anteayer":
                    final data = snap.data!
                        .where((v) => v.fecha.day == DateTime.now().day - 2)
                        .toList();
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return RecargaItem(
                              recarga: Recarga.fromVenta(data[i]));
                        });

                  default:
                    return ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          return RecargaItem(
                              recarga: Recarga.fromVenta(snap.data![i]));
                        });
                }
              }
              return const CircularProgressIndicator();
            }));
  }

  Widget venta(Venta venta) {
    return ListTile(
      title: Text(venta.descripcion),
      subtitle: Text("Telefono: " + venta.cliente),
      trailing: Column(
        children: [
          Text("Lps. ${venta.monto}"),
          const SizedBox(
            height: 5.0,
          ),
          Text(venta.fecha.toString().split(" ")[0]),
        ],
      ),
    );
  }
}
