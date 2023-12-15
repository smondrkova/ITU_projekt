import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                              'Review: ${review.review}',
                              style: TextStyle(color: Colors.white),
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
