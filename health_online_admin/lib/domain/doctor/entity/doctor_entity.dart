

class DoctorEntity {
  final String id;
  final String name;
  final String password;
  final String email;
  final String description;
  final String specialized;
  final int status;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.description,
    required this.specialized,
    required this.status,
  });
}
