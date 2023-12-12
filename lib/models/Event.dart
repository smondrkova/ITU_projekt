import 'dart:ffi';

class Event {
  String id;
  String name;
  DateTime date;
  String location;
  String categoryId;
  String description;
  double price;
  String ticketSellLink;
  String photoUrl;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.ticketSellLink,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'location': location,
      'categoryId': categoryId,
      'description': description,
      'price': price,
      'ticketSellLink': ticketSellLink,
      'photoUrl': photoUrl,
    };
  }
}
