import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 25,
            top: 50,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset('assets/icons/left_arrow_icon.svg'),
              ),
            ),
          ),
          const Positioned(
            left: 60,
            top: 48,
            child: Text(
              'Recenzie',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
