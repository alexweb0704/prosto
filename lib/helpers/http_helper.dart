import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../models/payment_type.dart';
import '../models/service.dart';
import '../models/task.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../models/current_user.dart';
import 'dart:convert';

class HttpHelper {
  static final String domain = 'http://prosto.iglight.uz/mob-api';

  static Future<List<Service>> getServices() async {
    final response = await http.get(HttpHelper.domain + '/services/get');

    if (await HttpHelper.errorChecking(response)) {
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

  static Future<Task> createTask(Map<String, dynamic> task) async {
    final response = await http.post(
      domain + 'tasks/create',
      headers: {"Content-type": "application/json"},
      body: task,
    );

    if (await HttpHelper.errorChecking(response)) {
      print('response erroring');
      return null;
    }
    var taskData = jsonDecode(response.body)['task'];
    return Task.fromJson(taskData);
  } 

  static Future<List<PaymentType>> getPaymentTypes() async {
    final response = await http.get(HttpHelper.domain + '/payment-types/get');

    if (await HttpHelper.errorChecking(response)) {
      print('response erroring');
      return null;
    }

    var paymentTypesData = jsonDecode(response.body)['payment_types'];

    List<PaymentType> paymentTypes = List();

    for (final paymentType in paymentTypesData) {
      paymentTypes.add(PaymentType.fromJson(paymentType));
    }
    return paymentTypes;
  }

  static errorChecking(http.Response response) {
    print(response.statusCode);
    if (response.statusCode == 200) {
      return false;
    } else if (response.statusCode == 403) {
      print(response.body);
    }
    return true;
  }

  static final LocalStorage storage = new LocalStorage('prosto_app');
  static getUser(context) async {
    print('get user method start');
    var currentUser = await HttpHelper.storage.getItem('currentUser');
    final token = currentUser['token'];

    final response = await http.get(
      domain + '/user/get',
      headers: {"Authorization": "Bearer $token"},
    );
    final body = response.body;
    print(body);
    if (response.statusCode == 200) {
      currentUser = CurrentUser.fromJson(jsonDecode(body), token);
      storage.setItem('currentUser', currentUser.toJsonEncodable());
      if (currentUser.name != '') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
      }
    } else if ((jsonDecode(body))['error'] == "token_not_provided") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else if ((jsonDecode(body))['error'] == "token_expired") {
      print('token refresh');
      final response = await http.post(
        domain + '/user/token-refresh',
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json",
        },
        body: '{"token": "$token"}',
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        currentUser['token'] = (jsonDecode(response.body))['token'];
        storage.setItem('currentUser', currentUser);
        HttpHelper.getUser(context);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    }
  }
}
