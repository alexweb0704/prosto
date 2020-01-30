class Status {
  int id;

  Status({this.id});

  factory Status.fromJson(Map<String, dynamic> status) {
    return Status(
      id: status['id'],
    );
  }
}
