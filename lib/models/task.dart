import '../models/offer.dart';
import '../models/payment_type.dart';
import '../models/service.dart';
import '../models/status.dart';
import '../models/user.dart';

class Task {
  int id;
  String title;
  String description;
  User user;
  Offer offer;
  List<Offer> offers;
  String address;
  double coorLat;
  double coorLong;
  int price;
  PaymentType paymentType;
  Service service;
  bool isRemote;
  Status status;
  DateTime createdAt;
  DateTime startedAt;
  DateTime finishedAt;

  Task({
    this.id,
    this.title,
    this.description,
    this.user,
    this.offer,
    this.offers,
    this.address,
    this.coorLat,
    this.coorLong,
    this.price,
    this.paymentType,
    this.service,
    this.isRemote,
    this.status,
    this.createdAt,
    this.startedAt,
    this.finishedAt,
  });

  factory Task.fromJson(Map<String, dynamic> task) {
    return Task(
      id: task['id'],
      title: task['title'],
      description: task['description'],
      user: User.fromJson(task['user']),
      offer: Offer.fromJson(task['offer']),
      offers: Offer.fromJsonToList(task['offers']),
      address: task['address'],
      coorLat: task['coor_lat'],
      coorLong: task['coor_long'],
      price: task['price'],
      paymentType: PaymentType.fromJson(task['payment_type']),
      service: Service.fromJson(task['service']),
      isRemote: task['is_remote'],
      status: Status.fromJson(task['status']),
      createdAt: task['created_at'],
      startedAt: task['started_at'],
      finishedAt: task['finished_at'],
    );
  }
}
