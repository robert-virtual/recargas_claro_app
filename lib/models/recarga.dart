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
}
