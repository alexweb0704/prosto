import 'package:flutter/foundation.dart';

class User {
  int id;
  String username;
  String name;
  String surname;
  String email;
  bool isActivated;

  User({
    @required this.id,
    @required this.username,
    this.name,
    this.surname,
    this.email,
    this.isActivated,
  });

  @protected
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      isActivated: json['is_activated'],
    );
  }
}
