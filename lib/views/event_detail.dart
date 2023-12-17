import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/models/Review.dart';
import 'package:itu/views/components/favorite_button.dart';
import 'package:itu/views/edit_event.dart';
import 'package:itu/views/reviews.dart';
import 'package:itu/views/send_invite.dart';

class EventDetail extends StatefulWidget {
  //final Function navigateToNewPage;
  Event event;

  EventDetail({required this.event, Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final EventController _eventController = EventController();
  bool isFavorite = false;
  bool isOwner = false;

  void getFavorite() async {
    bool isFavorite = await _eventController.isEventFavorite(widget.event.id);
    if (mounted) {
      setState(() {
        this.isFavorite = isFavorite;
      });
    }
  }

  void getOwner() async {
    bool isOwner = await _eventController.isEventOwner(widget.event);
    if (mounted) {
      setState(() {
        print(isOwner);
        this.isOwner = isOwner;
      });
    }
  }

  Widget buildButton(String text, Color color, [Widget? page]) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page ?? const Placeholder(),
        ),
      ),
      child: SizedBox(
        width: 339,
        height: 52,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 339,
                height: 52,
                decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventData() {
    return FutureBuilder<Event>(
      future: _eventController.getEventById(widget.event.id),
      builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Event? event = snapshot.data;

          if (event == null) {
            return const Text('Event not found');
          }

          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 275,
                  height: 275,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: event.photoUrl != ''
                          ? AssetImage(event.photoUrl)
                          : const AssetImage('assets/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 320,
                        child: Text(
                          event.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('dd.MM.yyyy').format(widget.event.date_time),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        event.place_name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        event.place_address,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(widget.event.date_time),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3B3B3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 321,
                        child: Text(
                          event.description,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                event.ticketSellLink != ''
                    ? buildButton("Vstupenky", Colors.white, null)
                    : const SizedBox.shrink(),
                const SizedBox(height: 8),
                if (DateTime.now().isBefore(event.date_time))
                  buildButton(
                      "Poslať pozvánku",
                      const Color.fromARGB(255, 122, 60, 194),
                      const SendInvitePage()),
                if (DateTime.now().isAfter(event.date_time))
                  buildButton("Recenzie", Colors.deepPurple,
                      ReviewsPage(eventId: event.id)),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _eventController.isEventFavorite(widget.event.id),
        _eventController.isEventOwner(widget.event),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          isFavorite = snapshot.data![0];
          isOwner = snapshot.data![1];

          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  buildEventData(),
                  Positioned(
                    left: 346,
                    top: 50,
                    child: FavoriteButton(
                      eventId: widget.event.id,
                      isFavorite: isFavorite,
                    ),
                  ),
                  if (isOwner)
                    Positioned(
                      left: 310,
                      top: 50,
                      child: GestureDetector(
                        onTap: () async {
                          // Navigate to the EditEventPage
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditEventPage(event: widget.event),
                            ),
                          );

                          widget.event = await _eventController
                              .getEventById(widget.event.id);

                          setState(() {});
                        },
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            'assets/icons/edit_icon.svg',
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 25,
                    top: 50,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: SvgPicture.asset(
                            'assets/icons/left_arrow_icon.svg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
