import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/main.dart';
import 'package:prosto/models/service.dart';

Future<List<Service>> getServices(map) async {
  print('get services method started');
  final response = await http.get(domain + '/services/get');

  final jsonData = await errorHelper(response, getServices, {});

  if (jsonData.containsKey('services') == false) {
    return null;
  }

  List<Service> services = List();

  for (final service in jsonData['services']) {
    services.add(Service.fromJson(service));
  }
  print("services: $services");

  await setServices(services);

  return services;
}

Future<bool> setServices(List<Service> services) async {
  await storage.ready;
  storage.setItem('services', Service.toJsonListEncodable(services));
  return true;
}
Future<List<Service>> getLocalServices() async {
  await storage.ready;
  final jsonServices = storage.getItem('services');
  print(jsonServices);
  List<Service> services = List();
  for (final service in jsonServices) {
    services.add(Service.fromJson(jsonDecode(service)));
  }
  return services;
}