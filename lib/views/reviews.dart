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

class _ReviewsPageState extends State<ReviewsPage> {
  final ReviewsController _reviewsController = ReviewsController();
  late Future<List<Review>> reviewsFuture;
  double averageRating = 0.0;
  final TextEditingController reviewController = TextEditingController();
  int userRating = 0;

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
          content: Text('Please provide a review and rating.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      Review newReview = Review(
        id: '', // Will be assigned by Firebase
        event: widget.eventId,
        review: reviewController.text,
        rating: userRating,
      );

      // Save the new review to Firebase
      await FirebaseFirestore.instance.collection('reviews').add({
        'event': newReview.event,
        'review': newReview.review,
        'rating': newReview.rating,
      });

      // Clear the text field and reset the user rating
      reviewController.clear();
      userRating = 0;

      // Refresh the reviews and update the average rating
      reviewsFuture = _reviewsController.fetchReviews(widget.eventId);
      _calculateAverageRating();

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Review added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error adding review: $e');
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding review. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  'Average Rating',
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
                  'Add Your Review',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                TextField(
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: 'Enter your review...',
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
                  'Your Rating',
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
                  child: Text('Submit Review',
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
                      'No reviews available.',
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
