import 'dart:convert';

import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/helpers/locale_storage_helper.dart';
import 'package:prosto/main.dart';
import 'package:http/http.dart' as http;

Future<String> getToken() async {
  String token = await LStorage.getItem('token');
  if (token == null || token == '') {
    return null;
  }
  return token;
}

Future<bool> setToken(token) async {
  await storage.ready;
  //print('soxraneniye tokena otklyuchena, ne zabut\' vklyuchit\'');
  storage.setItem('token', token);
  print('setted token to local storage' + token);
  return true;
}

Future<bool> deleteLocalToken() async {
  await storage.ready;
  //print('soxraneniye tokena otklyuchena, ne zabut\' vklyuchit\'');
  storage.deleteItem('token');
  print('local token deleted');
  return true;
}


Future<bool> invalidateToken(map) async {
  final String token = await getToken();
  final response = await http.post(
    domain + '/user/token-invalidate',
    headers: {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    },
    body: {'token': token}.toString(),
  );
  final dynamic jsonData = await errorHelper(response, invalidateToken, {});

  if (jsonData != 'token_invalidated') {
    // blyat' xuynya kakaya to
  }

  deleteLocalToken();
  return true;
}
