import "package:cloud_firestore/cloud_firestore.dart";

class EventController {
  // collection reference
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');
}
