// lib/models/Review.dart
/// Project: Evento
///
/// EventDetail page view.
///
/// 17.12.2023
///
/// @author Matej Tomko, xtomko06
///

class Review {
  final String id;
  final String event; // This is the ID of the event
  final String review;
  final int rating;
  final bool isCurrentUserReview;
  bool? isThumbsUp; // Make the property nullable

  Review({
    required this.id,
    required this.event,
    required this.review,
    required this.rating,
    required this.isCurrentUserReview,
    this.isThumbsUp, // Make the property nullable
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      event: json['event'] ?? '',
      review: json['review'] ?? '',
      rating: json['rating'] ?? 0,
      isCurrentUserReview: json['isCurrentUserReview'] ?? false,
      isThumbsUp: json['isThumbsUp'] ?? false, // Initialize the property
    );
  }
}
