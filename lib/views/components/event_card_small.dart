/// File: /lib/views/components/event_card_small.dart
/// Project: Evento
///
/// Event card on category detail page component.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/event_detail.dart';

class EventCardSmall extends StatelessWidget {
  Event event;

  EventCardSmall({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetail(event: event),
              ),
            ),
        child: SizedBox(
          width: 350,
          height: 186,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 350,
                  height: 117,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: event.photoUrl != ''
                          ? AssetImage(event.photoUrl)
                          : const AssetImage('assets/placeholder.png'),
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
                  width: 350,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
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
                      DateFormat('dd.MM.yyyy').format(event.date_time),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
