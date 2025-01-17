/// File: /lib/views/edit_event.dart
/// Project: Evento
///
/// Edit event page view.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/components/event_form.dart';
import 'package:itu/views/event_detail.dart';

class EditEventPage extends StatefulWidget {
  final Event event;

  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  EventController _eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 0, 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        child: SvgPicture.asset(
                            'assets/icons/left_arrow_icon.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'Uprav podujatie',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    GestureDetector(
                      onTap: () {
                        _eventController.deleteEvent(widget.event.id);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        child: SvgPicture.asset('assets/icons/delete_icon.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            EventForm(event: widget.event),
          ],
        ),
      ),
    ));
  }
}
