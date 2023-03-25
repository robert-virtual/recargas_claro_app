import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recargas_claro_app/models/recarga.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _RecargasProvider {


  late SharedPreferences _pref;

  Future<Map<String, List<Recarga>>> cargarDatos() async {
    _pref = await SharedPreferences.getInstance();
    if(_pref.getString("recargas") == null){
      print("refreshing recargas");
      final data = (await http.get(Uri.https("raw.githubusercontent.com","/robert-virtual/recargas_claro_app/master/data/data.json"))).body;
      await _pref.setString('recargas', data);
    }
    final data =  _pref.getString('recargas');
    final obj = jsonDecode(data!);

    Map<String, List<dynamic>> mapa = Map.from(obj);
    Map<String, List<Recarga>> listaElementos = {};

    /*
    convierte la lista dinamica a lista de recargas
    agrega los elementos a la lista 
    "listaElementos" a partir del "mapa"
     */
    mapa.forEach((key, lista) {
      listaElementos[key] =
          List.generate(lista.length, (i) => Recarga.fromJson(lista[i]));
    });

    return listaElementos;
  }
}

final recargasProvider = _RecargasProvider();


