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
}
