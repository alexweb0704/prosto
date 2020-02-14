class Offer {
  int id;
  Offer({
    this.id,
  });

  factory Offer.fromJson(Map<String, dynamic> offer) {
    if (offer == null) {
      return null;
    }
    return Offer(
      id: offer['id'],
    );
  }

  static List<Offer> fromJsonToList(List<dynamic> offers) {
    List<Offer> items = List();
    if (offers.length == 0) {
      return null;
    }
    for (final offer in offers) {
      items.add(Offer.fromJson(offer));
    }
    return items;
  }
}
