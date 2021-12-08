import 'package:recargas_claro_app/models/venta.dart';

class Recarga {
  String cod;
  String title;
  String description;
  String duration;
  int price;
  Recarga(
      {required this.cod,
      required this.price,
      required this.title,
      required this.description,
      required this.duration});

  factory Recarga.fromJson(Map json) {
    return Recarga(
      cod: json["cod"],
      price: json["price"],
      title: json["title"],
      description: json["description"],
      duration: json["duration"],
    );
  }
  factory Recarga.fromVenta(Venta venta) {
    return Recarga(
      cod: "",
      price: venta.monto.toInt(),
      title: venta.descripcion,
      description: "Fecha: "+venta.fecha.toString().split(" ")[0],
      duration: "Cliente: "+venta.cliente,
    );
  }
}
