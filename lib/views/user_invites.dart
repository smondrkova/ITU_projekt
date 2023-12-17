// import 'package:flutter/material.dart';
// import 'package:itu/models/Invite.dart'; // Import your Invite class
// import 'package:itu/models/Event.dart'; // Import your Event class
// import 'package:itu/controllers/InviteController.dart'; // Import your EventController and Invite class
// import 'package:itu/views/components/event_card.dart'; // Import your EventCard widget

// class UserInvitesPage extends StatefulWidget {
//   const UserInvitesPage({Key? key}) : super(key: key);

//   @override
//   State<UserInvitesPage> createState() => _UserInvitesPageState();
// }

// class _UserInvitesPageState extends State<UserInvitesPage> {
//   final InviteController _inviteController = InviteController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Unseen Invites'),
//       ),
//       body: StreamBuilder<List<Invite>>(
//         stream: _inviteController.getNotSeenInvites(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Invite> unseenInvites = snapshot.data!;
//             return buildEventsListView();
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }


//   Widget buildEventsListView() {
//     return StreamBuilder<List<Event>>(
//       stream: _inviteController.getAllUnseenEvents(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Text('Loading...');
//         }

//         List<Event> events = snapshot.data!;

//         return ListView.builder(
//           itemCount: events.length,
//           itemBuilder: (context, index) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // sem pojdu event cards
//                 GestureDetector(
//                   // onTap: () => Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) =>
//                   //         EventDetail(event: events[index]),
//                   //   ),
//                   // ),
//                   child: EventCard(
//                     event: events[index],
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/components/event_card.dart';

class UserInvitesPage extends StatefulWidget {
  const UserInvitesPage({super.key});

  @override
  State<UserInvitesPage> createState() => _UserInvitesPageState();
}

class _UserInvitesPageState extends State<UserInvitesPage> {
  final EventController _eventController = EventController();

  Widget buildInvitedEvents() {
    return StreamBuilder<List<Event>>(
      stream: _eventController.getInvitedEvents(),
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
      height: 640,
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
                'Tvoje pozvánky',
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
              child: buildInvitedEvents(),
            ),
          ),
        ],
      ),
    );
  }
}
