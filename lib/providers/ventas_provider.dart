import 'dart:convert';

import 'package:recargas_claro_app/models/venta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _VentasProvider {
  /*
  late = se inicialize posteriormente 
  a la inicializacion de la instancia de ventas provider
   */
  late List<Venta> _ventas;
  late SharedPreferences _pref;

  Future<void> addVenta(Venta venta) async {
    await getVentas();
    _ventas.add(venta);
    final string = jsonEncode(_ventas);
    await _pref.setString('historial', string);
  }

  Future<List<Venta>> getVentas() async {
    _pref = await SharedPreferences.getInstance();

    String string = _pref.getString('historial') ?? "[]";
    final obj = jsonDecode(string);
    List lista = List.from(obj);
    _ventas = List.generate(lista.length, (i) => Venta.fromJson(lista[i]));
    return _ventas;
  }
}

final ventasProvider = _VentasProvider();
