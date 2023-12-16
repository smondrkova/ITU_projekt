import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/components/event_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final EventController _eventController = EventController();

  Widget buildFavoriteEvents() {
    return StreamBuilder<List<Event>>(
      stream: _eventController.getFavoriteEvents(),
      builder: (context, snapshot) {
        print('StreamBuilder builder called');
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          print('No data in snapshot');
          return const Text('Loading...');
        }

        List<Event> events = snapshot.data!;
        print('Number of events: ${events.length}');

        // return ListView.builder(
        //   itemCount: events.length,
        //   itemBuilder: (context, index) {
        //     print('Building event card for event at index: $index');
        //     return Center(
        //       child: GestureDetector(
        //         child: EventCard(
        //           event: events[index],
        //         ),
        //       ),
        //     );
        //   },
        // );
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
              events.length,
              (index) {
                return EventCard(event: events[index]);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      height: 800,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          const Positioned(
            left: 25,
            top: 50,
            child: SizedBox(
              width: 153,
              height: 27,
              child: Text(
                'Obľúbené',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            top: 90,
            child: Container(
              child: buildFavoriteEvents(),
            ),
          ),
        ],
      ),
    );
  }
}
