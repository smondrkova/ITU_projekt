import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itu/models/Event.dart';

class EventCardSmall extends StatelessWidget {
  Event event;

  EventCardSmall({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 159,
        height: 186,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 159,
                height: 117,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(event.photoUrl),
                    fit: BoxFit.cover,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 117,
              child: Container(
                width: 159,
                height: 62,
                decoration: const ShapeDecoration(
                  color: Color(0xFF3B3B3B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 128,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy').format(event.date),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
