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
        event: data['event'] ?? '',
        user: data['user'] ?? '',
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
          date_time: data['date_time'] != null
              ? (data['date_time'] as Timestamp).toDate() // Use toDate() directly
              : DateTime.now(), // Provide a default date or handle differently
          place_address: data['place_address'] ?? '',
          place_name: data['place_name'] ?? '',
          categoryId: data['categoryId'] ?? '',
          organiserId: data['organiserId'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0).toDouble(), // Ensure the type is double
          ticketSellLink: data['ticketSellLink'] ?? '',
          photoUrl: data['photoUrl'] ?? '',
        );
      }).toList();
    });
  }

  Future<void> sendInvite(String eventId, String userId) async {
    try {
      Invite newInvite = Invite(
        id: '', // Will be assigned by Firebase
        event: eventId,
        user: userId,
        seen: false
      );

      await FirebaseFirestore.instance.collection('invites').add({
        'event': newInvite.event,
        'user': newInvite.user,
        'seen': newInvite.seen,
      });
    } catch (e) {
      print('Chyba pri pridávaní: $e');
      rethrow; // Re-throw the exception for the caller to handle
    }
  }

  Future<String?> findAndDeleteInvite(String eventId, String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invites')
          .where('event', isEqualTo: eventId)
          .where('user', isEqualTo: userId)
          .get();
      print(querySnapshot.docs.length);
      if (querySnapshot.docs.isNotEmpty) {
        String inviteId = querySnapshot.docs.first.id;
        print(inviteId);
        // Delete the invite
        await FirebaseFirestore.instance
          .collection('invites')
          .doc(inviteId)
          .delete();
          print('Deleted invite');
        return inviteId;
      } else {
        // Invite not found
        print('Not found');
        return null;
      }
    } catch (e) {
      print('Error finding and deleting invite: $e');
      return null;
    }
  }

  Future<void> deleteInvitesByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance
            .collection('invites')
            .where('user', isEqualTo: userId)
            .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Use a batch to efficiently delete multiple documents
        WriteBatch batch = FirebaseFirestore.instance.batch();

        querySnapshot.docs.forEach((doc) {
          batch.delete(doc.reference);
        });

        // Commit the batch to delete all documents
        await batch.commit();
      }
    } catch (e) {
      print('Error deleting invites by userId: $e');
    }
  }
}
