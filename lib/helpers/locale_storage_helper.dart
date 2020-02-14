import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:prosto/models/user.dart';

class LStorage {
  static final LocalStorage storage = new LocalStorage('prosto_app');
  static Future<dynamic> getItem(String item) async {
    await storage.ready;
    return await storage.getItem(item);
  }

  static Future<bool> setItem(String item, String data) async {
    await storage.ready;
    storage.setItem(item, data);
    return true;
  }

  static Future<User> getUser() async {
    print('started "get user from local storage" method');
    await storage.ready;
    print('storage readed');
    var currentUser = await storage.getItem('currentUser');
    print(currentUser);
    return User.fromJson(jsonDecode(currentUser));
  }
}
