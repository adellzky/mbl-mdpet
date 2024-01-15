class Katalog {
  String name, deskripsi, image;
  int harga;

  Katalog({
    required this.name,
    required this.harga,
    required this.deskripsi,
    required this.image,
  });

  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      name: json['name'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      image: json['image'],
    );
  }
}
