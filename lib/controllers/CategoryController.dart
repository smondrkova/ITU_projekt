// CategoryController.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Category.dart';

class CategoryController {
  List<Category> _getCategoriesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Category(
        id: doc.id,
        name: data['name'] ?? '',
        photoUrl: data['photoUrl'],
      );
    }).toList();
  }

  Widget buildCategoryListView() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          List<Category> categories =
              _getCategoriesFromSnapshot(snapshot.data!);

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(categories[index].name),
              );
            },
          );
        },
      ),
    );
  }
}


// possible foreign key solution:
// FirebaseFirestore rootRef = FirebaseFirestore.getInstance();
// CollectionReference itemsRef = rootRef.collection("items");
// Query query = itemsRef.whereEqualTo("postedBy", user_id);
// link: https://stackoverflow.com/questions/50659543/how-to-set-foreign-keys-in-firestore