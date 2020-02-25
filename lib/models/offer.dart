import 'package:prosto/models/payment_type.dart';
import 'package:prosto/models/user.dart';

class Offer {
  int id;
  User executor;
  String comment;
  int price;
  PaymentType paymentType;
  DateTime deletedAt;
  bool deletion = false;
  bool acceptance = false;

  Offer({
    this.id,
    this.executor,
    this.comment,
    this.price,
    this.paymentType,
    this.deletedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> offer) {
    if (offer == null) {
      return null;
    }
    print(offer['id']);
    return Offer(
      id: offer['id'],
      executor: User.fromJson(offer['executor']),
      comment: offer['comment'],
      price: offer['price'],
      paymentType: PaymentType.fromJson(offer['payment_type']),
      deletedAt: offer['deleted_at'] == null
          ? null
          : DateTime.parse(offer['deleted_at']['date']),
    );
  }

  static List<Offer> fromJsonToList(List<dynamic> offers) {
    List<Offer> items = List();
    print(offers);
    if (offers.length == 0) {
      return null;
    }
    for (final offer in offers) {
      items.add(Offer.fromJson(offer));
    }
    return items;
  }
}
