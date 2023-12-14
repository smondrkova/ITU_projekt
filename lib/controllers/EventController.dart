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
        name: data['name'] ?? '',
        date_time: data['date_time'] != null
            ? (data['date_time'] as Timestamp).toDate() // Use toDate() directly
            : DateTime.now(), // Provide a default date or handle differently
        location: data['place'] ?? '',
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
                padding: EdgeInsets.all(16.0), // Add padding for better spacing
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event Name: ${events[index].name}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: 8), // Add some space between the text fields
                    Text(
                      'Date: ${_formatDate(events[index].date_time)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Location: ${events[index].location}',
                      style: TextStyle(fontSize: 16),
                    ),
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
