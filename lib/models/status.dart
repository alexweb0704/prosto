class Status {
  int id;
  String name;
  String code;

  Status({
    this.id,
    this.name,
    this.code,
  });

  factory Status.fromJson(Map<String, dynamic> status) {
    return Status(
      id: status['id'],
      name: status['name'],
      code: status['code'],
    );
  }
}
