import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prosto/models/service.dart';

class User {
  int id;
  String username;
  num balance;
  String name;
  String surname;
  String email;
  String avatarUrl;
  bool isActivated;
  String gender;
  String passport;
  List<Service> services;

  User({
    @required this.id,
    @required this.username,
    this.name,
    this.balance,
    this.surname,
    this.email,
    this.avatarUrl,
    this.isActivated,
    this.services,
    this.gender,
    this.passport
  });

  @protected
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      balance: json['balance'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      avatarUrl: json.containsKey('avatarUrl')
          ? json['avatarUrl']
          : json['avatar'] != null
              ? json['avatar']['path']
              : null,
      isActivated: json['is_activated'],
      services: Service.fromJsonList(json['services']),
      gender: json['gender'],
      passport: json['passport'],
    );
  }
  toJsonEncodable() {
    Map<String, dynamic> m = new Map();
    m['id'] = id;
    m['username'] = username;
    m['balance'] = balance;
    m['name'] = name;
    m['surname'] = surname;
    m['email'] = email;
    m['avatarUrl'] = avatarUrl;
    m['isActivated'] = isActivated;
    m['gender'] = gender;
    m['passport'] = passport;
    m['services'] = Service.toJsonListEncodable(services);
    return jsonEncode(m);
  }
}
