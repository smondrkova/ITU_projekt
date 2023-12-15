// CategoryController.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Category.dart';

class CategoryController {
  Stream<List<Category>> getCategories() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .map(getCategoriesFromSnapshot);
  }

  List<Category> getCategoriesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Category(
        id: doc.id,
        name: data['name'] ?? '',
        photoUrl: data['photoUrl'],
      );
    }).toList();
  }
}
