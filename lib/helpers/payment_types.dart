import 'dart:convert';

import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/main.dart';
import 'package:prosto/models/payment_type.dart';
import 'package:http/http.dart' as http;

Future<List<PaymentType>> getPaymentTypes (map) async {
  print('get payment types method start');

  final response = await http.get(domain + '/services/get');

  final jsonData = await errorHelper(response, getPaymentTypes, {});


  if (jsonData.containsKey('payment_types') == false) {
    return null;
  }
  
  List<PaymentType> paymentTypes = List();

  for (final paymentType in jsonData['payment_types']) {
    paymentTypes.add(PaymentType.fromJson(paymentType));
  }

  return paymentTypes;
}

Future<bool> setPaymentTypes (List<PaymentType> paymentTypes) async {
  await storage.ready;
  print('payment types set to local storage started');
  storage.setItem('paymentTypes', PaymentType.toJsonListEncodable(paymentTypes));
  print('payment types setted to local storage');
  return true;
}

Future<List<PaymentType>> getLocalPaymentTypes() async {
  await storage.ready;
  final jsonPaymentTypes = storage.getItem('paymentTypes');
  print(jsonPaymentTypes);
  List<PaymentType> paymentType = List();
  for (final paymentType in jsonPaymentTypes) {
    paymentType.add(PaymentType.fromJson(jsonDecode(paymentType)));
  }
  return paymentType;
}