class Review {
  final String id;
  final String event; // This is the ID of the event
  final String review;
  final int rating;

  Review({
    required this.id,
    required this.event,
    required this.review,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      event: json['event'] ?? '',
      review: json['review'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}
