import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itu/controllers/CategoryController.dart';
import 'package:itu/controllers/UserController.dart';
import 'package:itu/models/User.dart';
import 'package:timezone/timezone.dart';
import '../models/Event.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class EventController {
  final _categoryController = CategoryController();
  final _userController = UserController();

  final createFormKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();

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
            ? (data['date_time'] as Timestamp).toDate()
            : DateTime.now(),
        place_address: data['place_address'] ?? '',
        place_name: data['place_name'] ?? '',
        categoryId: data['category'] ?? '',
        organiserId: data['organiser'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        ticketSellLink: data['ticketSellLink'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
      );
    }).toList();
  }

  Stream<List<Event>> getEventsByCategory(String categoryId) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('category', isEqualTo: categoryId)
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  Stream<List<Event>> getEventsByOrganiser(String organiserId) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('organiser', isEqualTo: organiserId)
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  Future<Event> getEventById(String eventId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .get();
    return _getEventFromDocument(doc);
  }

  Future<Event> getRandomEvent() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    List<DocumentSnapshot> events = querySnapshot.docs;
    if (events.isEmpty) {
      throw Exception('No events found');
    }
    DocumentSnapshot randomEventDoc = events[Random().nextInt(events.length)];
    return _getEventFromDocument(randomEventDoc);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  Stream<List<Event>> getFavoriteEvents() {
    return FirebaseFirestore.instance
        .collection('favourites')
        .snapshots()
        .asyncMap((snapshot) => _getFavoriteEventsFromSnapshot(snapshot));
  }

  Future<List<Event>> _getFavoriteEventsFromSnapshot(
      QuerySnapshot snapshot) async {
    return Future.wait(snapshot.docs.map((doc) async {
      String eventId = (doc.data() as Map<String, dynamic>)['event'];
      print("Fetching event with ID: $eventId");
      DocumentSnapshot eventDoc = await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .get();
      return _getEventFromDocument(eventDoc);
    }));
  }

  Event _getEventFromDocument(DocumentSnapshot doc) {
    if (doc.data() == null) {
      // Handle the null case here. For example, return a default Event:
      return Event(
        id: '',
        name: '',
        date_time: DateTime.now(),
        place_address: '',
        place_name: '',
        categoryId: '',
        organiserId: '',
        description: '',
        price: 0.0,
        ticketSellLink: '',
        photoUrl: '',
      );
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      name: data['name'] ?? '',
      date_time: data['date_time'] != null
          ? (data['date_time'] as Timestamp).toDate()
          : DateTime.now(),
      place_address: data['place_address'] ?? '',
      place_name: data['place_name'] ?? '',
      categoryId: data['category'] ?? '',
      organiserId: data['organiser'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      ticketSellLink: data['ticketSellLink'] ?? '',
      photoUrl: data['photoUrl'],
    );
  }

  void addEventToFavorites(String eventId) {
    FirebaseFirestore.instance.collection('favourites').add({
      'event': eventId,
    });
  }

  Future<bool> isEventFavorite(String eventId) {
    return FirebaseFirestore.instance
        .collection('favourites')
        .where('event', isEqualTo: eventId)
        .get()
        .then((snapshot) => snapshot.docs.isNotEmpty);
  }

  void removeEventFromFavorites(String eventId) {
    FirebaseFirestore.instance
        .collection('favourites')
        .where('event', isEqualTo: eventId)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future<String> saveImageLocally(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final localImageFile = File('$path/$timestamp.png');

    await imageFile.copy(localImageFile.path);

    return localImageFile.path;
  }

  void createEvent(Event event, File? imageFile) async {
    if (!createFormKey.currentState!.validate()) {
      return;
    }

    createFormKey.currentState!.save();

    String localImagePath;
    if (imageFile == null) {
      localImagePath = '';
    } else {
      localImagePath = await saveImageLocally(imageFile);
    }

    // String categoryId =
    //     await _categoryController.getCategoryIdByName(event.categoryId);

    User? user = await _userController.fetchAndAssignUser();
    if (user != null) {
      event.organiserId = user.id;
    }

    FirebaseFirestore.instance.collection('events').add({
      'name': event.name,
      'date_time': event.date_time,
      'place_address': event.place_address,
      'place_name': event.place_name,
      'category': event.categoryId,
      'organiser': event.organiserId,
      'description': event.description,
      'price': event.price,
      'ticketSellLink': event.ticketSellLink,
      'photoUrl': localImagePath,
    });
  }

  void deleteEvent(String eventId) {
    FirebaseFirestore.instance.collection('events').doc(eventId).delete();
  }

  Future<bool> isEventOwner(Event event) async {
    print('Event id: ${event.organiserId}');
    User? user = await _userController.fetchAndAssignUser();
    print("User: ${user!.id}");
    if (user != null) {
      print("Event organiser ID: ${event.organiserId}");
      return event.organiserId == user.id;
    } else {
      return false;
    }
  }

  void updateEvent(Event event, File? imageFile) async {
    if (!editFormKey.currentState!.validate()) {
      return;
    }

    editFormKey.currentState!.save();

    String localImagePath;
    if (imageFile != null) {
      localImagePath = await saveImageLocally(imageFile);
    } else {
      localImagePath = event.photoUrl;
    }

    String categoryId =
        await _categoryController.getCategoryIdByName(event.categoryId);

    print('Updating event with category ID: ${categoryId}');

    FirebaseFirestore.instance.collection('events').doc(event.id).update({
      'name': event.name,
      'date_time': event.date_time,
      'place_address': event.place_address,
      'place_name': event.place_name,
      'category': categoryId,
      'organiser': event.organiserId,
      'description': event.description,
      'price': event.price,
      'ticketSellLink': event.ticketSellLink,
      'photoUrl': localImagePath,
    });
  }
}
