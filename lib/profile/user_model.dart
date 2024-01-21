class User {
  int id;
  String name;
  String phone;
  String address;
  String email;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id: json?['id'] as int? ?? 0,
      name: json?['name'] as String? ?? '',
      phone: json?['nomortelp'] as String? ?? '',
      address: json?['alamat'] as String? ?? '',
      email: json?['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nomortelp': phone,
      'alamat': address,
      'email': email,
    };
  }
}

