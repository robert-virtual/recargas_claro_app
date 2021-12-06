import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:recargas_claro_app/models/recarga.dart';

class _RecargasProvider {



  Future<Map<String, List<Recarga>>> cargarDatos() async {
    final data = await rootBundle.loadString("data/data.json");

    final obj = jsonDecode(data);

    Map<String, List<dynamic>> mapa = Map.from(obj);
    Map<String, List<Recarga>> listaElementos = {};

    mapa.forEach((key, lista) {
      listaElementos[key] =
          List.generate(lista.length, (i) => Recarga.fromJson(lista[i]));
    });

    return listaElementos;
  }
}

final recargasProvider = _RecargasProvider();


