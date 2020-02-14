import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prosto/helpers/locale_storage_helper.dart';

final domain = 'http://prosto.iglight.uz/mob-api';

errorHelper(http.Response response, handler, Map params) async {
  print('helper started');
  final statusCode = response.statusCode;
  final resBody = await jsonDecode(response.body);
  print('status code: $statusCode');
  print('body: $resBody');
  if (statusCode == 200) {
    return resBody;
  } else if (statusCode == 401 && resBody['error'] == 'token_expired') {
    if (! await refreshToken()) {
      return null;
    }
    return handler(params);
  } else if (statusCode == 401 && resBody['error'] != 'token_expired') {}
}

Future<bool> refreshToken() async {
  final token = await LStorage.getItem('token');
  print(token);
  if (token == null || token == '') {
    return false;
  }
  final response = await http.post(
    domain + '/user/token-refresh',
    headers: {"Authorization": "Bearer $token"},
  );
  print("refreshing token status code: ${response.statusCode}");
  print("refreshing token response body: ${response.body}");
  final headers = response.headers;
  print(headers);
  if (headers.containsKey('authorization') == false) {
    return false;
  }
  print(headers['authorization']);
  final String newTokenWitBearer = headers["authorization"];
  final newToken = (newTokenWitBearer.split(' '))[1];
  print("new token: $newToken");
  await LStorage.setItem("token", newToken);
  return true;
}
