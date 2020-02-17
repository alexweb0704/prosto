import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prosto/helpers/locale_storage_helper.dart';
import 'package:prosto/models/user.dart';
import '../models/payment_type.dart';
import '../models/service.dart';
import '../models/task.dart';
import '../screens/login_screen.dart';
import 'dart:convert';

class HttpHelper {
  static final String domain = 'http://prosto.iglight.uz/mob-api';
  static LoginScreen loginScreen = LoginScreen();

  static Future<List<Service>> getServices() async {
    final response = await http.get(HttpHelper.domain + '/services/get');

    final errors = await HttpHelper.errorChecking(response);

    if (errors.containsKey('error')) {
      print('response erroring');
      return null;
    }

    var servicesData = jsonDecode(response.body)['services'];

    List<Service> services = List();

    for (final service in servicesData) {
      services.add(Service.fromJson(service));
    }
    return services;
  }

  static Future<Task> createTask(Map<String, dynamic> task, context) async {
    var token = await HttpHelper.getLocalToken();
    if (token == null) {
      print('token null');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HttpHelper.loginScreen,
        ),
      );
      return null;
    }
    print(task);
    final response = await http.post(
      domain + '/tasks/create',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(task),
    );

    final errors = await checkingErrors(response);

    print(errors);
    if (errors.containsKey('restart') && errors['restart'] == true) {
      print('restarted "get user" method');
      return createTask(task, context);
    }

    if (errors.containsKey('error')) {
      print(errors["error"]);
      return null;
    }

    if (errors.containsKey('success') && errors['success'] == true) {
      print('ok');
    }
    var taskData = jsonDecode(response.body)['task'];
    return Task.fromJson(taskData);
  }

  static Future<List<PaymentType>> getPaymentTypes() async {
    final response = await http.get(HttpHelper.domain + '/payment-types/get');

    final errors = await checkingErrors(response);

    print(errors);
    if (errors.containsKey('restart') && errors['restart'] == true) {
      print('restarted "get user" method');
      return getPaymentTypes();
    }

    if (errors.containsKey('error')) {
      print(errors["error"]);
      return null;
    }

    if (errors.containsKey('success') && errors['success'] == true) {
      print('ok');
    }
    var paymentTypesData = jsonDecode(response.body)['payment_types'];

    List<PaymentType> paymentTypes = List();

    for (final paymentType in paymentTypesData) {
      paymentTypes.add(PaymentType.fromJson(paymentType));
    }
    return paymentTypes;
  }

  static errorChecking(http.Response response) async {
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return {"success": true};
    } else if (response.statusCode == 401) {
      return tokenErrors(response);
    } else {
      return {"error": "error"};
    }
  }

  static tokenErrors(http.Response response) async {
    var body = jsonDecode(response.body);
    print(body);
    if (body['error'] == 'invalid_token') {
      return {"token": "invalid"};
    } else if (body['error'] == 'token_expired') {
      return await refreshToken()
          ? {"token": "refreshed"}
          : {"token": "not_refreshed"};
    } else if (body['error'] == 'token_not_provided') {
      return {"redirect": "/login"};
    }
  }

  static Future<String> getLocalToken() async {
    print('get local token method starting');
    var token = await LStorage.getItem('token');
    print(token);
    return token;
  }

  static Future<Map<String, String>> logining({
    String username,
    String password: null,
  }) async {
    Map<String, String> body = {};
    print(username);

    if (username != null && username != '') {
      body['username'] = username;
    }

    if (password != null && password != '') {
      body['password'] = password;
    }
    print(body.toString());
    final response = await http.post(
      domain + '/user/login-from-phone',
      headers: {"Content-type": "application/json"},
      body: jsonEncode(body),
    );
    var errorChecking = await HttpHelper.errorChecking(response);
    if (errorChecking.containsKey('error')) {
      print('response erroring');
    }
    if (errorChecking.containsKey('token') &&
        errorChecking['token'] == 'updated') {
      return logining(username: username, password: password);
    }
    print(response.body);
    if (jsonDecode(response.body).containsKey('password')) {
      print(jsonDecode(response.body)['password']);
      return {'password': '${jsonDecode(response.body)['password']}'};
    }
    if (jsonDecode(response.body).containsKey('user')) {
      User currentUser = User.fromJson(jsonDecode(response.body));
      print(currentUser.toJsonEncodable());
      LStorage.setItem('currentUser', currentUser.toJsonEncodable());
    }
    if (jsonDecode(response.body).containsKey('token')) {
      await LStorage.setItem('token', jsonDecode(response.body)['token']);
      print('token saved');
      return {'success': 'success'};
    }
    return {'error': 'error'};
  }

  static Future<User> getUser(context) async {
    var token = await LStorage.getItem('token');
    print(token);
    User currentUser;
    final response = await http.get(
      domain + '/user/get',
      headers: {"Authorization": "Bearer $token"},
    );

    print(response.body);

    final errors = await checkingErrors(response);

    print(errors);
    if (errors.containsKey('restart') && errors['restart'] == true) {
      print('restarted "get user" method');
      return getUser(context);
    }

    if (errors.containsKey('error')) {
      print(errors["error"]);
      return null;
    }

    if (errors.containsKey('success') && errors['success'] == true) {
      print('ok');
    }

    currentUser = User.fromJson(jsonDecode(response.body)['user']);
    print(currentUser.toJsonEncodable());
    LStorage.setItem('currentUser', currentUser.toJsonEncodable());

    return currentUser;
  }

  static checkingErrors(http.Response response) async {
    final statusCode = response.statusCode;
    final resBody = jsonDecode(response.body);
    Map<String, dynamic> answer;

    print(statusCode);
    print(resBody);

    switch (statusCode) {
      case 200:
        {
          answer = {"success": true};
        }
        break;
      case 400:
        {
          answer = {"error": "bad_request"};
        }
        break;
      case 500:
        {
          answer = {"error": "server_errors"};
        }
        break;
      case 401:
        {
          print("401 exception");
          switch (resBody['error']) {
            case "token_expired":
              {
                print("token_expired");
                if (await refreshToken()) {
                  print("token_refreshed");
                  answer = {"restart": true};
                } else {
                  answer = {"error": "error_refreshing_token"};
                }
              }
              break;
            case "token_not_provided":
              {
                answer = {"token": "not_provided"};
              }
              break;
            case "token_invalid":
              {
                answer = {"token": "invalid"};
              }
              break;
            default:
              {
                answer = {"errror": "error"};
              }
              break;
          }
        }
        break;
      default:
        {
          answer = {"errror": "error"};
        }
        break;
    }
    print(answer);
    return answer;
  }

  static Future<bool> refreshToken() async {
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
}
