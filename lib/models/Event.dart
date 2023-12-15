import 'dart:ffi';

class Event {
  String id;
  String name;
  DateTime date_time;
  String location;
  String categoryId;
  String organiserId;
  String description;
  double price;
  String ticketSellLink;
  String photoUrl;

  Event({
    required this.id,
    required this.name,
    required this.date_time,
    required this.location,
    required this.categoryId,
    required this.organiserId,
    required this.description,
    required this.price,
    required this.ticketSellLink,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date_time':
          date_time != null ? date_time : null, // Check for nullability
      'location': location,
      'categoryId': categoryId,
      'organiserId': organiserId,
      'description': description,
      'price': price,
      'ticketSellLink': ticketSellLink,
      'photoUrl': photoUrl,
    };
  }
}
