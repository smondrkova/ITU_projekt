import 'dart:ffi';

class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String categoryId;
  final String description;
  final Float price;
  final String ticketSellLink;
  final String photoUrl;

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
}
