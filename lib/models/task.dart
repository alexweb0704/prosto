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
      user: task['user'] != null ? User.fromJson(task['user']) : null,
      offer: Offer.fromJson(task['offer']),
      offers: Offer.fromJsonToList(task['offers']),
      address: task['address'],
      coorLat: task['coor_lat'] is String
          ? double.parse(task['coor_lat'])
          : task['coor_lat'],
      coorLong: task['coor_long'] is String
          ? double.parse(task['coor_long'])
          : task['coor_long'],
      price: task['price'] is String ? int.parse(task['price']) : task['price'],
      paymentType: task['payment_type'] == null
          ? null
          : PaymentType.fromJson(task['payment_type']),
      service:
          task['service'] == null ? null : Service.fromJson(task['service']),
      isRemote: task['is_remote'] is String
          ? bool.fromEnvironment(task['is_remote'])
          : task['is_remote'] != null ? task['is_remote'] : false,
      status: task['status'] == null ? null : Status.fromJson(task['status']),
      createdAt: task['created_at'] == null
          ? null
          : DateTime.parse(task['created_at']['date']),
      startedAt: task['started_at'] == null
          ? null
          : DateTime.parse(task['started_at']['date']),
      finishedAt: task['finished_at'] == null
          ? null
          : DateTime.parse(task['finished_at']['date']),
    );
  }
}
