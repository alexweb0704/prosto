import '../models/user.dart';
import 'package:flutter/foundation.dart';

class CurrentUser extends User {
  String token;
  CurrentUser({
    @required this.token,
    @required int id,
    @required String username,
    String name,
    String surname,
    String email,
    bool isActivated,
  }) : super(
          id: id,
          username: username,
          name: name,
          surname: surname,
          email: email,
          isActivated: isActivated,
        );

    
  factory CurrentUser.fromJson(Map<String, dynamic> json, String token) {
    return CurrentUser(
      token: token,
      id: json['user']['id'],
      username: json['user']['username'],
      name: json['user']['name'],
      surname: json['user']['surname'],
      email: json['user']['email'],
      isActivated: json['user']['is_activated'],
    );
  }

  toJsonEncodable() {
    Map<String, dynamic> m = new Map();
    m['token'] = token;
    m['id'] = id;
    m['username'] = username;
    m['name'] = name;
    m['surname'] = surname;
    m['email'] = email;
    m['isActivated'] = isActivated;
    return m;
  }
}
