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

  Future<String> getCategoryIdByName(String name) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('name', isEqualTo: name)
        .get();
    return snapshot.docs.first.id;
  }

  Future<String> getCategoryNameById(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').doc(id).get();
    return (snapshot.data() as Map<String, dynamic>)['name'];
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
