import 'dart:convert';

import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/helpers/token.dart';
import 'package:prosto/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:prosto/main.dart';

Future<User> getCurrentUser(map) async {
  print('get current user method started');
  final token = await getToken();

  if (token == null) {
    return null;
  }
  final response = await http.get(
    domain + '/user/get',
    headers: {"Authorization": "Bearer $token"},
  );
  final jsonUser = await errorHelper(response, getCurrentUser, {});

  if (jsonUser is User) {
    return jsonUser;
  }

  if (jsonUser != null && jsonUser.containsKey('user')) {
    User user = User.fromJson(jsonUser['user']);
    setUserLS(user);
    return user;
  }
  return null;
}

Future<Map<String, dynamic>> login(Map map) async {
  print('login method started');
  Map body = {};
  print("map: $map");
  if (map.containsKey('username')) {
    body['username'] = map['username'];
  }

  if (map.containsKey('password')) {
    body['password'] = map['password'];
  }

  print(body.toString());

  final response = await http.post(
    domain + '/user/login-from-phone',
    headers: {"Content-type": "application/json"},
    body: jsonEncode(body),
  );

  final jsonData = await errorHelper(response, getCurrentUser, map);
  print(jsonData);
  if (jsonData != null && jsonData.containsKey('errors')) {
    print('errors');
    return jsonData;
  }

  if (jsonData != null && jsonData.containsKey('password')) {
    return {"password": jsonData['password']};
  }

  if (jsonData != null && jsonData.containsKey('token')) {
    setToken(jsonData['token']);
  }

  if (jsonData != null && jsonData.containsKey('user')) {
    setUserLS(User.fromJson(jsonData['user']));
  }
  return {'success': 'success'};
}

Future<bool> setUserLS(User user) async {
  await storage.ready;
  storage.setItem('currentUser', user.toJsonEncodable());
  return true;
}

Future<User> getLocalCurrentUser() async {
  await storage.ready;
  return User.fromJson(jsonDecode(await storage.getItem('currentUser')));
}

Future<bool> updateUser(map) async {
  final token = await getToken();
  final response = await http.post(
    domain + '/user/update',
    headers: {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    },
    body: jsonEncode(map),
  );

  final jsonData = await errorHelper(response, updateUser, map);

  if (jsonData is bool) {
    return jsonData;
  }

  if (jsonData == null && jsonData.containsKey('user') == false) {
    return false;
  }

  User user = User.fromJson(jsonData['user']);
  setUserLS(user);
  return true;
}
