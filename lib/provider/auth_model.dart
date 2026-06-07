class AuthUser {
  String refreshToken;
  String accessToken;
  Student student;

  AuthUser({
    required this.refreshToken,
    required this.accessToken,
    required this.student,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    refreshToken: json["refreshToken"],
    accessToken: json["accessToken"],
    student: Student.fromJson(json["student"]),
  );
}

class Student {
  String id;
  String name;
  String type;
  String email;
  String phone;
  bool phoneVerified;
  bool emailVerified;
  bool active;
  DateTime createdAt;
  DateTime lastUpdateAt;
  bool deleted;
  dynamic deletedAt;
  String? image;

  Student({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    required this.phone,
    required this.phoneVerified,
    required this.emailVerified,
    required this.active,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.deleted,
    required this.deletedAt,
    required this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    phone: json["phone"],
    phoneVerified: json["phoneVerified"],
    emailVerified: json["emailVerified"],
    active: json["active"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastUpdateAt: DateTime.parse(json["lastUpdateAt"]),
    deleted: json["deleted"],
    deletedAt: json["deletedAt"],
    image: json["image"],
  );
}
