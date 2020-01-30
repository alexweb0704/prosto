
class Service {
  int id;
  String name;
  int tasksCount;
  Service({
    this.id,
    this.name,
    this.tasksCount,
  });

  factory Service.fromJson(Map<String, dynamic> data) {
    return Service(
      id: data['id'],
      name: data['name'],
      tasksCount: data['tasksCount'],
    );
  }
}
