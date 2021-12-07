class Venta {
  String descripcion;
  double monto;
  String cliente;/* # de telefono */
  DateTime fecha;

  Venta(
      {required this.descripcion,
      required this.cliente,
      String? fecha_,
      required this.monto})
      : fecha = 
      (fecha_ != null) 
        ? DateTime.parse(fecha_) 
        : DateTime.now();

  factory Venta.fromJson(Map<String,dynamic> json) {
    return Venta(
      cliente: json["cliente"],
      descripcion: json["descripcion"],
      monto: json["monto"],
      fecha_: json["fecha"],
    );
  }
  Map<String, dynamic> toJson() => {
      "descripcion":descripcion,
      "cliente":cliente,
      "monto":monto,
      "fecha":fecha.toIso8601String()
  };
  

}
