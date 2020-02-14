import 'dart:convert';

class Service {
  int id;
  String name;
  int tasksCount;
  Service({
    this.id,
    this.name,
    this.tasksCount,
  });

  static List<Service> fromJsonList(List data) {
    List<Service> services = List();
    for (final serviceJson in data) {
      if (serviceJson is String) {
        services.add(Service.fromJson(jsonDecode(serviceJson)));
      } else {
        services.add(Service.fromJson((serviceJson)));
      }
    }
    return services;
  }

  factory Service.fromJson(Map<String, dynamic> data) {
    return Service(
      id: data['id'],
      name: data['name'],
      tasksCount: data['tasksCount'],
    );
  }
  toJsonEncodable() {
    Map<String, dynamic> m = new Map();
    m['id'] = id;
    m['name'] = name;
    return jsonEncode(m);
  }
  static toJsonListEncodable(List<Service> services) {
    List l = List();
    for (final service in services) {
      l.add(service.toJsonEncodable());
    }
    return l;
  }
}
