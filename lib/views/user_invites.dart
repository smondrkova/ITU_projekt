import 'package:flutter/material.dart';
import 'package:itu/models/Invite.dart'; // Import your Invite class
import 'package:itu/models/Event.dart'; // Import your Event class
import 'package:itu/controllers/InviteController.dart'; // Import your EventController and Invite class
import 'package:itu/views/components/event_card.dart'; // Import your EventCard widget

class UserInvitesPage extends StatefulWidget {
  const UserInvitesPage({Key? key}) : super(key: key);

  @override
  State<UserInvitesPage> createState() => _UserInvitesPageState();
}

class _UserInvitesPageState extends State<UserInvitesPage> {
  final InviteController _inviteController = InviteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unseen Invites'),
      ),
      body: StreamBuilder<List<Invite>>(
        stream: _inviteController.getNotSeenInvites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Invite> unseenInvites = snapshot.data!;
            return buildEventsListView();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


  Widget buildEventsListView() {
    return StreamBuilder<List<Event>>(
      stream: _inviteController.getAllUnseenEvents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        List<Event> events = snapshot.data!;

        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // sem pojdu event cards
                GestureDetector(
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         EventDetail(event: events[index]),
                  //   ),
                  // ),
                  child: EventCard(
                    event: events[index],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}