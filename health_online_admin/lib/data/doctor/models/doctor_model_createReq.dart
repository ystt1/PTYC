

class DoctorModelCreateReq {

  final String name;
  final String password;
  final String email;
  final String description;
  final String specialized;

  DoctorModelCreateReq({required this.name, required this.password, required this.email, required this.description, required this.specialized});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'password': this.password,
      'email': this.email,
      'description': this.description,
      'specialized': this.specialized,
    };
  }

  factory DoctorModelCreateReq.fromMap(Map<String, dynamic> map) {
    return DoctorModelCreateReq(
      name: map['name'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      description: map['description'] as String,
      specialized: map['specialized'] as String,
    );
  }
}


