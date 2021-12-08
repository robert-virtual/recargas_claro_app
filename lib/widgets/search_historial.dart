import 'package:flutter/material.dart';
import 'package:recargas_claro_app/models/recarga.dart';
import 'package:recargas_claro_app/models/venta.dart';
import 'package:recargas_claro_app/widgets/recarga_item.dart';

class HistorialSearch extends SearchDelegate {
  Venta? seleccionada;
  final Future<List<Venta>> historial;
  HistorialSearch({required this.historial});

  @override
  TextInputType? get keyboardType => TextInputType.phone;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: RecargaItem(recarga: Recarga.fromVenta(seleccionada!),),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Venta>>(
        future: historial,
        builder: (context, snap) {
          if (snap.hasData) {
            final data =
                snap.data!.where((v) => v.cliente.startsWith(query)).toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showResults(
                            context,
                          );
                          seleccionada = data[i];
                        },
                        title: Text(data[i].descripcion),
                        subtitle: Text(data[i].cliente),
                        trailing: Column(
                          children: [
                            Text('Lps. ${data[i].monto}'),
                            Text(data[i].fecha.toString().split(" ")[0]),
                          ],
                        ),
                      )
                    ],
                  );
                });
          }
          return const Text("cargando...");
        });
  }
}
