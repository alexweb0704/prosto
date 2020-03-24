import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prosto/helpers/locale_storage_helper.dart';
import 'package:prosto/main.dart';

errorHelper(http.Response response, handler, Map params) async {
  print('helper started');
  final statusCode = response.statusCode;
  final resBody = await jsonDecode(response.body);
  print('status code: $statusCode');
  print('body: $resBody');
  if (statusCode == 200) {
    return resBody;
  } else if (statusCode == 400) {
    return resBody;
  } else if (statusCode == 401 && resBody['error'] == 'token_expired') {
    if (!await refreshToken()) {
      print('asd');
      return null;
    }
    return await handler(params);
  } else if (statusCode == 401 && resBody.containsKey('errors')) {
    print('error');
    return resBody;
  }
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
    print('token not recived');
    return false;
  }
  print(headers['authorization']);
  final String newTokenWithBearer = headers["authorization"];
  final String newToken = (newTokenWithBearer.split(' '))[1];
  print("new token: $newToken");
  await LStorage.setItem("token", newToken);
  return true;
}
