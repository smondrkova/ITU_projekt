import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Invite.dart';
import '../models/Event.dart';

class InviteController {
  List<Invite> _getInvitesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Invite(
        id: doc.id,
        eventId: data['event'] ?? '',
        userId: data['user'] ?? '',
        seen: data['seen'] ?? false,
      );
    }).toList();
  }

  Stream<List<Invite>> getInvites() {
    return FirebaseFirestore.instance
        .collection('invites')
        .snapshots()
        .map(_getInvitesFromSnapshot);
  }

  Stream<List<Invite>> getNotSeenInvites() {
    return FirebaseFirestore.instance
        .collection('invites')
        .where('seen',
            isEqualTo:
                false) 
        .snapshots()
        .map(_getInvitesFromSnapshot);
  }

  Stream<List<Event>> getAllUnseenEvents() {
    return FirebaseFirestore.instance
        .collection('invites')
        .where('seen',
            isEqualTo:
                false) 
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Event(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          date_time: data['date_time'] ?? '',
          location: data['location'] ?? '',
          photoUrl: data['photoUrl'],
          categoryId: data['category'] ?? '',
          price: data['price'] ?? '',
          ticketSellLink: data['ticketSellLink'] ?? '',
        );
      }).toList();
    });
  }
}
