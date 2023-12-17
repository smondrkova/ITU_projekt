/// File: /lib/views/components/event_card_big.dart
/// Project: Evento
///
/// Event card on home page component.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/event_detail.dart';

class EventCardBig extends StatefulWidget {
  const EventCardBig({super.key});

  @override
  State<EventCardBig> createState() => _EventCardBigState();
}

class _EventCardBigState extends State<EventCardBig> {
  final EventController _eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _eventController.getRandomEvent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text('Error loading event');
          } else {
            Event event = snapshot.data!;

            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    if (snapshot.data != null) {
                      return EventDetail(event: snapshot.data!);
                    } else {
                      return const Text('No event data');
                    }
                  },
                ),
              ),
              child: Container(
                width: 420,
                height: 195,
                padding: const EdgeInsets.only(
                  top: 79,
                  left: 30,
                  right: 80,
                  bottom: 14,
                ),
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: (event.photoUrl != '')
                        ? AssetImage(event.photoUrl)
                        : const AssetImage(
                            'assets/placeholder.png',
                          ) as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 280,
                            child: Text(
                              event.name,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 234,
                            child: Text(
                              DateFormat('dd.MM.yyyy HH:mm')
                                  .format(event.date_time),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 275,
                            child: Text(
                              event.place_name,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
