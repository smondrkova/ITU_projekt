import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/components/favorite_button.dart';
import 'package:itu/views/event_detail.dart';

class EventCard extends StatelessWidget {
  //const EventCard(Set<dynamic> set, {super.key});
  final Event event;
  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    EventController _eventController = EventController();

    return Column(children: [
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetail(event: event),
          ),
        ),
        child: Container(
          width: 350,
          height: 132,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 149,
                top: 0,
                child: Container(
                  width: 195,
                  height: 132,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF3B3B3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 160,
                  height: 132,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: event.photoUrl != ''
                          ? Image.file(File(event.photoUrl)).image
                          : const AssetImage('assets/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 172,
                top: 25,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 115,
                      child: Text(
                        DateFormat('dd.MM.yyyy').format(event.date_time),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 148,
                      child: Text(
                        event.place_name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 305,
                top: 15,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: FutureBuilder<bool>(
                    future: _eventController.isEventFavorite(event.id),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return FavoriteButton(
                            eventId: event.id,
                            isFavorite: snapshot.data ?? false,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ]);
  }
}
