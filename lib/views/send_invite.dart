/// File: /lib/views/send_invite.dart
/// Project: Evento
///
/// Send invite page view.
///
/// 17.12.2023
///
/// @author Erik Žák xzaker00
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itu/controllers/InviteController.dart';
import 'package:itu/models/User.dart';
import 'package:itu/controllers/UserController.dart';


class SendInvitePage extends StatefulWidget {
  final String eventId;

  const SendInvitePage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<SendInvitePage> createState() => _SendInvitePageState();
}

class _SendInvitePageState extends State<SendInvitePage> {
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
              'Pošli pozvánku',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              UserSearchDelegate delegate = UserSearchDelegate(context: context, eventId: widget.eventId);
              showSearch(
                context: context,
                delegate: delegate,
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 650.0),
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
                            'Hľadaj užívateľov...',
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
          ),
        ],
      ),
    );
  }
}

/// A search delegate class used to search through users
class UserSearchDelegate extends SearchDelegate {
  final UserController _userController = UserController();
  final InviteController _inviteController = InviteController();
  final BuildContext context;
  final String eventId;

  UserSearchDelegate({required this.context, required this.eventId});

  /// Returns a list of widgets that are displayed as the actions for the search bar
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

  /// Returns a widget that is displayed as the leading icon on the left side of the search bar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  /// Returns search results based on the current query
  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<User>>(
      stream: _userController.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<User> users = snapshot.data ?? [];

        List<User> displayUsers = query.isEmpty
            ? users
            : users
                .where((user) =>
                    _containsFullName(user, query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemCount: displayUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${displayUsers[index].name} ${displayUsers[index].surname}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                _sendInviteAndNavigateBack(context, eventId, displayUsers[index].id);
              },
            );
          },
        );
      },
    );
  }

  /// Returns suggestions based on the current query
  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<User>>(
      stream: _userController.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<User> users = snapshot.data ?? [];

        List<User> displayUsers = query.isEmpty
            ? users
            : users
                .where((user) =>
                    _containsFullName(user, query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemCount: displayUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${displayUsers[index].name} ${displayUsers[index].surname}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                _sendInviteAndNavigateBack(context, eventId, displayUsers[index].id);
              },
            );
          },
        );
      },
    );
  }

  bool _containsFullName(User user, String query) {
    final fullName = '${user.name.toLowerCase()} ${user.surname.toLowerCase()}';
    return fullName.contains(query);
  }

  Future<void> _sendInviteAndNavigateBack(BuildContext context, String event, String user) async {
    try {
      /// Send the invite
      await _inviteController.sendInvite(event, user);

      /// Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pozvánka bola úspešne odoslaná!'),
          backgroundColor: Colors.green,
        ),
      );

      /// Navigate back to the EventDetail screen
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      /// Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vyskytla sa chyba pri odosielaní pozvánky. Skúste to znova.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}