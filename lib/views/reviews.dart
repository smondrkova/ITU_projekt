// lib/views/reviews.dart
/// Project: Evento
///
/// EventDetail page view.
///
/// 17.12.2023
///
/// @author Matej Tomko, xtomko06
///

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/ReviewsController.dart';
import '../models/Review.dart';

class ReviewsPage extends StatefulWidget {
  final String eventId;

  const ReviewsPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _EditReviewDialog extends StatefulWidget {
  final TextEditingController editedReviewController;
  final int initialRating;
  final Function(int) onRatingChanged;
  final VoidCallback onSave;

  const _EditReviewDialog({
    Key? key,
    required this.editedReviewController,
    required this.initialRating,
    required this.onRatingChanged,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditReviewDialogState createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<_EditReviewDialog> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    // Initialize _currentRating with the initialRating
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Upraviť Review', style: TextStyle(color: Colors.white)),
      content: Column(
        children: [
          TextField(
            controller: widget.editedReviewController,
            onChanged: (text) {
              // Handle the edited text
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Review',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      index < _currentRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      // Update _currentRating when a star is pressed
                      setState(() {
                        _currentRating = index + 1;
                      });
                      // Notify the parent about the rating change
                      widget.onRatingChanged(_currentRating);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle cancel
            Navigator.pop(context);
          },
          child: Text('Zrušiť', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle save
            widget.onSave();
            // Close the popup window
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
          ),
          child: Text('Uložiť', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class _ReviewsPageState extends State<ReviewsPage> {
  final ReviewsController _reviewsController = ReviewsController();
  late Future<List<Review>> reviewsFuture;
  double averageRating = 0.0;
  final TextEditingController reviewController = TextEditingController();
  int userRating = 0;
  final String currentUserId =
      'OeBrMEXcqvW0kRrcF5hq'; // Replace with your actual user ID

  @override
  void initState() {
    super.initState();

    // Initialize the future to fetch reviews for the specific event
    reviewsFuture = _reviewsController.fetchReviews(widget.eventId);

    // Calculate average rating
    _calculateAverageRating();
  }

  Future<void> _calculateAverageRating() async {
    List<Review> reviews = await reviewsFuture;

    if (reviews.isNotEmpty) {
      double totalRating = reviews
          .map((review) => review.rating)
          .reduce((a, b) => a + b)
          .toDouble();
      averageRating = totalRating / reviews.length;

      // Update the widget after calculating the average rating
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _addReview() async {
    if (reviewController.text.isEmpty || userRating == 0) {
      // Display an error message if review or rating is not provided
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Prosím poskytnite hodnotenie a review.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      Review newReview = Review(
        id: '',
        event: widget.eventId,
        review: reviewController.text,
        rating: userRating,
        isCurrentUserReview: true,
      );

      // Save the new review to Firebase
      await FirebaseFirestore.instance.collection('reviews').add({
        'event': newReview.event,
        'review': newReview.review,
        'rating': newReview.rating,
        'isCurrentUserReview': newReview.isCurrentUserReview,
      });

      // Clear the text field and reset the user rating
      reviewController.clear();
      userRating = 0;

      // Close the keyboard by unfocusing the current focus
      FocusScope.of(context).unfocus();

      // Refresh the reviews and update the average rating
      reviewsFuture = _reviewsController.fetchReviews(widget.eventId);
      _calculateAverageRating();

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Review bola úspešne pridaná!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error adding review: $e');
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Vyskytla sa chyba pri pridávaní review. Skúste to znova.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteReview(Review review) async {
    try {
      await _reviewsController.deleteReview(review.id);

      // Refresh the reviews and update the average rating
      reviewsFuture = _reviewsController.fetchReviews(widget.eventId);
      _calculateAverageRating();

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Review bola úspešne odstránená!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Vyskytla sa chyba pri odstraňovaní review. Skúste to znova.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _editReview(Review review) async {
    final TextEditingController editedReviewController =
        TextEditingController(text: review.review);

    int editedRating = review.rating; // New variable to store the edited rating

    await showDialog(
      context: context,
      builder: (context) => _EditReviewDialog(
        editedReviewController: editedReviewController,
        initialRating: editedRating,
        onRatingChanged: (int newRating) {
          // Update the editedRating when the rating changes
          setState(() {
            editedRating = newRating;
          });
        },
        onSave: () async {
          // Handle save
          try {
            await FirebaseFirestore.instance
                .collection('reviews')
                .doc(review.id)
                .update({
              'review': editedReviewController.text,
              'rating': editedRating, // Update the rating in Firestore
              // You can update other fields as needed
            });

            // Refresh the reviews and update the average rating
            reviewsFuture = _reviewsController.fetchReviews(widget.eventId);
            _calculateAverageRating();

            // Display a success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Review bola úspešne upravená!'),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            // Display an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Vyskytla sa chyba pri upravovaní review.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset('assets/icons/left_arrow_icon.svg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Recenzie',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text(
                  'Priemerné hodnotenie',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < averageRating ? Colors.amber : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pridať Review',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                TextField(
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: 'Pridajte svoju review...',
                    fillColor: Colors.black,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Vaše hodnotenie',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          userRating = index + 1;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        color: index < userRating ? Colors.amber : Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addReview,
                  child: Text('Pridať Review',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Review>>(
              future: reviewsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Tento event nemá žiadne reivews.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  List<Review> reviews = snapshot.data!;
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      Review review = reviews[index];
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${review.review}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  color: index < review.rating
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Conditionally show edit and delete buttons based on the flag
                        trailing: review.isCurrentUserReview != false
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => _editReview(review),
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteReview(review),
                                    color: Colors.red,
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  // Toggle the color locally
                                  setState(() {
                                    review.isThumbsUp =
                                        !(review.isThumbsUp ?? false);
                                  });
                                },
                                child: Icon(
                                  Icons.thumb_up,
                                  color: review.isThumbsUp ?? false
                                      ? Colors.purple
                                      : Colors.grey,
                                ),
                              ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
