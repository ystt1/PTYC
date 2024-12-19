class Patient {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final int status;

  const Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.status,
  });
}