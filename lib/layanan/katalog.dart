class Katalog {
  String name, deskripsi, image;
  int id_order, harga;

  Katalog({
    required this.id_order,
    required this.name,
    required this.harga,
    required this.deskripsi,
    required this.image,
  });

  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      id_order: json['id_order'],
      name: json['name'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      image: json['image'],
    );
  }
}
