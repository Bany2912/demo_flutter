class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final DateTime birthDate;
  final String phoneNumber;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.phoneNumber,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'birthDate': birthDate.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    DateTime? birthDate,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, birthDate: $birthDate, phoneNumber: $phoneNumber)';
  }
}