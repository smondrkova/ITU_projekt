import "package:cloud_firestore/cloud_firestore.dart";
import "package:itu/models/Event.dart";

class EventController {
  // collection reference
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');

  Future<void> createEvent(Event event) async {
    try {
      Map<String, dynamic> eventData = event.toMap();
      await eventCollection.add(eventData);
    } catch (e) {
      print("Error creating event: $e");
    }
  }
}
