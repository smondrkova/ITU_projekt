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
                return GestureDetector(
                  onTap: () {
                    _inviteController.findAndDeleteInvite(events[index].id, currentUserId);
                  },
                  child: EventCard(event: events[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       // Customize your app bar as needed
  //       title: Text('Your Invites'),
  //     ),
  //     body: Container(
  //       width: 365,
  //       height: 640,
  //       clipBehavior: Clip.antiAlias,
  //       decoration: const BoxDecoration(color: Colors.black),
  //       child: Stack(
  //         children: [
  //           const Positioned(
  //             left: 25,
  //             top: 50,
  //             child: SizedBox(
  //               width: 153,
  //               height: 27,
  //               child: Text(
  //                 'Tvoje pozvánky',
  //                 style: TextStyle(
  //                   fontSize: 24,
  //                   color: Colors.white, // Set the desired text color
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             left: 23,
  //             top: 90,
  //             child: Container(
  //               child: buildInvitedEvents(),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
              padding: const EdgeInsets.only(top: 25.0), // Adjust the top padding as needed
              child: Container(
                child: buildInvitedEvents(),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 15, // Adjust the bottom position as needed
            child: GestureDetector(
              onTap: () {
                // Add your onTap logic for the button here
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

