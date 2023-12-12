import "package:cloud_firestore/cloud_firestore.dart";
import "package:itu/models/Event.dart";

class CategoryController {
  // collection reference
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  Future<List<String>> getCategories() async {
    List<String> categories = [];
    await categoryCollection.get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        categories.add(element.data().toString());
      }
    });
    return categories;
  }
}
