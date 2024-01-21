class User {
  String name;
  String phone;
  String address;
  String email;

  User({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });
}
void main() {
  // Membuat instance baru dari kelas User
  User modelUser = User(
    name: "John Doe",
    phone: "123-456-7890",
    address: "123 Main St, Cityville",
    email: "john.doe@example.com",
  );
}