import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prosto/helpers/errors_helper.dart';
import 'package:prosto/helpers/token.dart';
import 'package:prosto/main.dart';
import 'package:prosto/models/offer.dart';

Future<bool> canCreate(map) async {
  final token = await getToken();
  final response = await http.get(
    domain + '/offers/can-create',
    headers: {"Authorization": "Bearer $token"},
  );
  final jsonData = await errorHelper(response, canCreate, {});
  if (jsonData) {
    return true;
  }
  return false;
}

Future<Offer> createOffer(map) async {
  final token = await getToken();
  final response = await http.post(
    domain + '/offers/create',
    headers: {
      "Authorization": "Bearer $token",
      "Content-type": "application/json",
    },
    body: jsonEncode(map),
  );

  final jsonData = await errorHelper(response, createOffer, map);
  print(jsonData);
  if (jsonData != null && jsonData.containsKey('offer')) {
    return Offer.fromJson(jsonData['offer']);
  }
  return null;
}

Future<bool> deleteOffer(map) async {
  int id = map['id'];
  final token = await getToken();
  final response = await http.delete(
    domain + '/offers/delete/$id',
    headers: {"Authorization": "Bearer $token"},
  );
  final jsonData = await errorHelper(response, deleteOffer, map);
  if (jsonData == true) {
    return true;
  }
  return false;
}
