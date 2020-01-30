class Offer {
  int id;
  Offer({
    this.id,
  });

  factory Offer.fromJson(Map<String, dynamic> offer) {
    return Offer(
      id: offer['id'],
    );
  }

  static List<Offer> fromJsonToList(List<Map<String, dynamic>> offers) {
    List<Offer> items = List();
    for (final offer in offers) {
      items.add(Offer.fromJson(offer));
    }
    return items;
  }
}
