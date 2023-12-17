/// File: /lib/controllers/EventController.dart
/// Project: Evento
///
/// EventController class for managing event data.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itu/controllers/CategoryController.dart';
import 'package:itu/controllers/UserController.dart';
import 'package:itu/models/User.dart';
import '../models/Event.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class EventController {
  final _categoryController = CategoryController();
  final _userController = UserController();

  final createFormKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();

  /// Returns stream of all events.
  Stream<List<Event>> getEvents() {
    return FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  /// Returns stream of events for home page.
  Stream<List<Event>> getEventsForHomePage() {
    return FirebaseFirestore.instance
        .collection('events')
        .limit(3)
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  /// Returns list of events from snapshot.
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

  /// Fetches events with given category ID.
  Stream<List<Event>> getEventsByCategory(String categoryId) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('category', isEqualTo: categoryId)
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  /// Fetches events with given organiser ID.
  Stream<List<Event>> getEventsByOrganiser(String organiserId) {
    return FirebaseFirestore.instance
        .collection('events')
        .where('organiser', isEqualTo: organiserId)
        .snapshots()
        .map(_getEventsFromSnapshot);
  }

  /// Fetches events with given event ID.
  Future<Event> getEventById(String eventId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .get();
    return _getEventFromDocument(doc);
  }

  /// Fetches one random event from database.
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

  /// Fetches all favourite events.
  Stream<List<Event>> getFavoriteEvents() {
    return FirebaseFirestore.instance
        .collection('favourites')
        .snapshots()
        .asyncMap((snapshot) => _getEventsFromAnotherTable(snapshot));
  }

  Stream<List<Event>> getInvitedEvents(String userId) {
    return FirebaseFirestore.instance
        .collection('invites')
        .where('user', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) => _getEventsFromAnotherTable(snapshot));
  }

  /// Fetches list of favourite favourite events from snapshot.
  Future<List<Event>> _getEventsFromAnotherTable(QuerySnapshot snapshot) async {
    return Future.wait(snapshot.docs.map((doc) async {
      String eventId = (doc.data() as Map<String, dynamic>)['event'];
      DocumentSnapshot eventDoc = await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .get();
      return _getEventFromDocument(eventDoc);
    }));
  }

  Event _getEventFromDocument(DocumentSnapshot doc) {
    if (doc.data() == null) {
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

  /// Adds event to favourites.
  void addEventToFavorites(String eventId) {
    FirebaseFirestore.instance.collection('favourites').add({
      'event': eventId,
    });
  }

  /// Checks if event is favourite.
  Future<bool> isEventFavorite(String eventId) {
    return FirebaseFirestore.instance
        .collection('favourites')
        .where('event', isEqualTo: eventId)
        .get()
        .then((snapshot) => snapshot.docs.isNotEmpty);
  }

  /// Removes event from favourites.
  void removeEventFromFavorites(String eventId) {
    FirebaseFirestore.instance
        .collection('favourites')
        .where('event', isEqualTo: eventId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  /// Saves image locally.
  Future<String> saveImageLocally(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final localImageFile = File('$path/$timestamp.png');

    await imageFile.copy(localImageFile.path);

    return localImageFile.path;
  }

  /// Creates event and saves it to database.
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

  /// Deletes event from database.
  void deleteEvent(String eventId) {
    bool isFavorite = isEventFavorite(eventId) as bool;
    if (isFavorite) {
      removeEventFromFavorites(eventId);
    }

    FirebaseFirestore.instance.collection('events').doc(eventId).delete();
  }

  /// Checks if user is event owner.
  Future<bool> isEventOwner(Event event) async {
    User? user = await _userController.fetchAndAssignUser();
    if (user != null) {
      return event.organiserId == user.id;
    } else {
      return false;
    }
  }

  /// Updates event in database.
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
