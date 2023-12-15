import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itu/views/event_detail.dart';
import '../models/Event.dart';
import '../controllers/EventController.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 50.0), // Adjust the top value as needed
          child: Container(
            height: 45,
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
            child: Stack(
              children: [
                Positioned(
                  left: 19,
                  top: 14,
                  child: SizedBox(
                    width: 260,
                    height: 22,
                    child: Text(
                      'Hľadaj...',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 8,
                  child: Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: SvgPicture.asset('assets/icons/search_icon.svg'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final EventController eventController = EventController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Event>>(
      stream: eventController.getEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Event> events = snapshot.data ?? [];

        List<Event> displayEvents = query.isEmpty
            ? events
            : events
                .where((event) =>
                    event.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemCount: displayEvents.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                displayEvents[index].name,
                style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              onTap: () {
                navigateItem(context, displayEvents[index]);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Event>>(
      stream: eventController.getEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Event> events = snapshot.data ?? [];

        List<Event> displayEvents = query.isEmpty
            ? events
            : events
                .where((event) =>
                    event.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemCount: displayEvents.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                displayEvents[index].name,
                style: TextStyle(
                    color: Colors.white,
                ),
              ),
              onTap: () {
                navigateItem(context, displayEvents[index]);
              },
            );
          },
        );
      },
    );
  }

  void navigateItem(BuildContext context, Event selectedEvent) {
  // Navigate to the EventDetail view
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetail(event: selectedEvent),
    ),
  );
}

}
