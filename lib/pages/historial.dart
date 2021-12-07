import 'package:flutter/material.dart';
import 'package:recargas_claro_app/models/venta.dart';
import 'package:recargas_claro_app/providers/ventas_provider.dart';

class HistorialPage extends StatefulWidget {
  HistorialPage({Key? key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  late Future<List<Venta>> ventas;
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
          title: const Text("Historial de ventas"),
        ),
        body: FutureBuilder<List<Venta>>(
            future: ventas,
            builder: (context, snap) {
              if (snap.hasData) {
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snap.data![i].descripcion),
                    subtitle:Text("Telefono: "+snap.data![i].cliente),
                    trailing: Column(
                      children: [
                        Text("Lps. ${snap.data![i].monto}"),
                        const SizedBox(height: 5.0,),
                        Text(snap.data![i].fecha.toString().split(" ")[0]),
                      ],
                    ),
                  );
                });
              }
              return const CircularProgressIndicator();
            }));
  }
}
