import 'dart:convert';

class PaymentType {
  int id;
  String name;
  PaymentType({
    this.id,
    this.name,
  });

  factory PaymentType.fromJson(Map<String, dynamic> paymentType) {
    return PaymentType(
      id: paymentType['id'],
      name: paymentType['name'],
    );
  }

  toJsonEncodable() {
    Map<String, dynamic> m = new Map();
    m['id'] = id;
    m['name'] = name;
    return jsonEncode(m);
  }

  static toJsonListEncodable(List<PaymentType> paymentTypes) {
    List l = List();
    for (final service in paymentTypes) {
      l.add(service.toJsonEncodable());
    }
    return l;
  }
}
