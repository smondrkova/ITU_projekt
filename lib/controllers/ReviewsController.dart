// lib/controllers/ReviewsController.dart
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
          isCurrentUserReview: data['isCurrentUserReview'] ?? false,
          isThumbsUp: data['isThumbsUp'] ?? false, // Initialize the property
        );
      }));

      return reviews;
    } catch (e) {
      print('Chyba pri hľadaní: $e');
      return [];
    }
  }

  Future<void> addReview(String eventId, String reviewText, int rating) async {
    try {
      Review newReview = Review(
        id: '', // Will be assigned by Firebase
        event: eventId,
        review: reviewText,
        rating: rating,
        isCurrentUserReview: true,
        isThumbsUp: false, // Initialize the property
      );

      await FirebaseFirestore.instance.collection('reviews').add({
        'event': newReview.event,
        'review': newReview.review,
        'rating': newReview.rating,
        'isCurrentUserReview': newReview.isCurrentUserReview,
        'isThumbsUp':
            newReview.isThumbsUp, // Include the property in the database
      });
    } catch (e) {
      print('Chyba pri pridávaní: $e');
      rethrow; // Re-throw the exception for the caller to handle
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      await FirebaseFirestore.instance
          .collection('reviews')
          .doc(reviewId)
          .delete();
    } catch (e) {
      print('Chyba pri mazaní: $e');
      rethrow; // Re-throw the exception for the caller to handle
    }
  }
}
