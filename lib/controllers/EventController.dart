import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Event.dart';
import 'package:intl/intl.dart';

class EventController {
  Stream<List<Event>> getEvents() {
    return FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  Stream<List<Event>> getEventsForHomePage() {
    return FirebaseFirestore.instance
        .collection('events')
        .limit(3)
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  List<Event> _getEventsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Event(
        id: doc.id,
        name: data['name'] ?? '',
        date_time: data['date_time'] != null
            ? (data['date_time'] as Timestamp).toDate() // Use toDate() directly
            : DateTime.now(), // Provide a default date or handle differently
        location: data['place'] ?? '',
        categoryId: data['categoryId'] ?? '',
        organiserId: data['organiserId'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(), // Ensure the type is double
        ticketSellLink: data['ticketSellLink'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
      );
    }).toList();
  }

  Stream<List<Event>> getEventsByCategory(String categoryId) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('category',
            isEqualTo:
                categoryId) // Replace 'category' with your actual category field name
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  Stream<List<Event>> getEventsByOrganiser(String organiserId) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('organiser',
            isEqualTo:
                organiserId) // Replace 'organiserId' with your actual organiserId field name
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
}
