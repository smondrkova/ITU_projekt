import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Category.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/components/event_card.dart';
import 'package:itu/views/components/event_card_small.dart';

class CategoryDetail extends StatefulWidget {
  final Category category;
  //final Function navigateToNewPage;

  const CategoryDetail({required this.category, Key? key}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final EventController _eventController = EventController();

  Widget buildEventList() {
    print("Category ID: ${widget.category.id}");

    return SizedBox(
      width: 400,
      height: 858,
      child: StreamBuilder<List<Event>>(
        stream: _eventController.getEventsByCategory(widget.category.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          List<Event> events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              //return EventCardSmall(event: events[index]);
              return EventCardSmall(event: events[index]);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        // child: buildEventList(),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 400,
                height: 301,
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
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 400,
                        height: 200,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF9B40E1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 19,
                      top: 90,
                      child: SizedBox(
                        width: 227,
                        height: 99,
                        child: Text(
                          widget.category.name,
                          style: const TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
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
            ),
            Positioned(
              left: 25,
              top: 200,
              child: Container(
                width: 400,
                height: 657,
                child: buildEventList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
