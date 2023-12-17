/// File: /lib/views/user_invites.dart
/// Project: Evento
///
/// User invites page view.
///
/// 17.12.2023
///
/// @author Erik Žák xzaker00
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/controllers/InviteController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/models/Invite.dart';
import 'package:itu/views/components/event_card.dart';

class UserInvitesPage extends StatefulWidget {
  const UserInvitesPage({super.key});

  @override
  State<UserInvitesPage> createState() => _UserInvitesPageState();
}

class _UserInvitesPageState extends State<UserInvitesPage> {
  final InviteController _inviteController = InviteController();
  final EventController _eventController = EventController();
  final String currentUserId = 'OeBrMEXcqvW0kRrcF5hq';

  Widget buildInvitedEvents() {
    return StreamBuilder<List<Event>>(
      stream: _eventController.getInvitedEvents(currentUserId),
      builder: (context, snapshot) {
        print('StreamBuilder builder called');
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          print('No data in snapshot');
          return const Text('Loading...');
        }

        List<Event> events = snapshot.data!;
        print('Number of events: ${events.length}');
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

  Future<void> _deleteInvites(String userId) async {
    try {
      // Deletes all invites for the current user
      await _inviteController.deleteInvitesByUserId(currentUserId);

      // Refresh the invites page
      if (mounted) {
        setState(() {});
      }

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pozvánky boli úspešne odstránené!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Vyskytla sa chyba pri odstraňovaní pozvánok. Skúste to znova.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 25,
            top: 50,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset('assets/icons/left_arrow_icon.svg'),
              ),
            ),
          ),
          const Positioned(
            left: 60,
            top: 48,
            child: Text(
              'Tvoje pozvánky',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Positioned(
            left: 23,
            top: 90,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                child: buildInvitedEvents(),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 15,
            child: GestureDetector(
              onTap: () {
                _deleteInvites(currentUserId);
              },
              child: Container(
                width: 375,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
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
                          horizontal: 20, vertical: 10),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Vymaž pozvánky',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

