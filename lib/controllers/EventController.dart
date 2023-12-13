import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Event.dart';
import 'package:intl/intl.dart';

class EventController {
  List<Event> _getEventsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Event(
        id: doc.id,
        name: data['title'] ?? '',
        date_time: data['date'] != null
            ? (data['date'] as Timestamp).toDate() // Use toDate() directly
            : DateTime.now(), // Provide a default date or handle differently
        location: data['location'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(), // Ensure the type is double
        ticketSellLink: data['ticketSellLink'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
      );
    }).toList();
  }

  Widget buildEventListView() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          List<Event> events = _getEventsFromSnapshot(snapshot.data!);

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Container(
                // Customize this based on how you want to display events
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(events[index].name),
                    Text(_formatDate(
                        events[index].date_time)), // Format the date
                    Text(events[index].location),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
}
