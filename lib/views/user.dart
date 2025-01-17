/// File: /lib/views/user.dart
/// Project: Evento
///
/// User page view.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itu/views/user_invites.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/controllers/UserController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/models/User.dart';
import 'package:itu/views/components/event_card.dart';
import 'package:itu/views/create_event.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController _userController = UserController();
  final EventController _eventController = EventController();

  Future<User?>? userFuture;
  Stream<List<Event>>? eventsStream;
  String? organiserId;

  @override
  void initState() {
    super.initState();
    userFuture = _userController.fetchAndAssignUser();
    userFuture!.then((user) {
      organiserId = user!.id;
      eventsStream = _eventController.getEventsByOrganiser(organiserId!);
    });
  }

  Widget buildUser() {
    return FutureBuilder<User?>(
      future: userFuture,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        User? user = snapshot.data;

        organiserId = user!.id;

        return Stack(
          children: [
            Positioned(
              left: 106,
              top: 85,
              child: Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF3B3B3B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset(
                    'assets/icons/user_photo_icon.svg',
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 252,
              child: SizedBox(
                width: 334,
                child: Text(
                  user.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 336),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 1000),
                        child: buildUserEvents(),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateEventPage(),
                          ),
                        ),
                        child: Container(
                          width: 328,
                          height: 39,
                          padding: const EdgeInsets.only(left: 35, right: 36),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 21, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: SvgPicture.asset(
                                          "assets/icons/plus_icon.svg"),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Vytvoriť nové podujatie',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => //widget.navigateToNewPage('UserInvitesPage'),
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserInvitesPage()),
                        ),
                        child: Container(
                          width: 328,
                          height: 39,
                          margin: const EdgeInsets.only(
                              top: 10), // Adjust the spacing as needed
                          padding: const EdgeInsets.only(left: 35, right: 36),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 21, vertical: 10),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Exclude the plus icon for this GestureDetector
                                    SizedBox(width: 10),
                                    Text(
                                      'Tvoje pozvánky',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildUserEvents() {
    return StreamBuilder(
        stream: eventsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          List<Event> events = snapshot.data!;
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: 360,
          height: 1000,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              buildUser(),
              const Positioned(
                left: 21,
                top: 306,
                child: SizedBox(
                  width: 287,
                  height: 30,
                  child: Text(
                    'Moje podujatia',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 10,
                top: 50,
                child: SizedBox(
                  width: 229,
                  height: 43,
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 330,
                top: 50,
                child: Container(
                  width: 28,
                  height: 28,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset('assets/icons/logout_icon.svg'),
                ),
              ),
            ],
          ),
        ));
  }
}
