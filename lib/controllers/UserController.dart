// UserController.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/User.dart'; // Make sure to replace 'User' with the actual class representing a user in your app

class UserController {
  User? currentUser;

  Stream<List<User>> getUsers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map(getUsersFromSnapshot);
  }

  List<User> getUsersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return User(
        id: doc.id,
        name: data['name'] ?? '',
        surname: data['surname'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        photoUrl: data['photoUrl'],
        password: data['password'],
      );
    }).toList();
  }

  Future<User?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return User(
          id: doc.id,
          name: data['name'] ?? '',
          surname: data['surname'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          photoUrl: data['photoUrl'],
          password: data['password'],
        );
      } else {
        return null; // User with the specified ID not found
      }
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print("Error fetching user by ID: $e");
      return null;
    }
  }

  Future<User?> fetchAndAssignUser() async {
    User? user = await getUserById("OeBrMEXcqvW0kRrcF5hq");
    currentUser = user;
    print("Fetched user: $user");
    print("Current user: $currentUser");

    return user;
  }

  // User fetchCurrentUser() {
  //   fetchAndAssignUser();
  //   print("Current user after fetching: $currentUser");
  //   return currentUser!;
  // }
}
