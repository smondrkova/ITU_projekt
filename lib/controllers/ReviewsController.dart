import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Review.dart';

class ReviewsController {
  Future<List<Review>> fetchReviews(String eventId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('reviews')
          .where('event', isEqualTo: eventId)
          .get();

      List<Review> reviews = await Future.wait(snapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Review(
          id: doc.id,
          event: data['event'] ?? '',
          review: data['review'] ?? '',
          rating: data['rating'] ?? 0,
        );
      }));

      return reviews;
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }
}
