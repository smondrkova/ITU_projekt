import 'dart:ffi';

class Event {
  String id;
  String name;
  DateTime date_time;
  String place_address;
  String place_name;
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
    required this.place_address,
    required this.place_name,
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
      'place_address': place_address,
      'place_name': place_name,
      'categoryId': categoryId,
      'organiserId': organiserId,
      'description': description,
      'price': price,
      'ticketSellLink': ticketSellLink,
      'photoUrl': photoUrl,
    };
  }

  String getAssetPath() {
    return photoUrl ?? 'assets/placeholder.png';
  }
}
