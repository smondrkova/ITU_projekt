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
              UserSearchDelegate delegate = UserSearchDelegate(eventId: widget.eventId);
              showSearch(
                context: context,
                delegate: delegate,
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 650.0), // Adjust the bottom value as needed
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

class UserSearchDelegate extends SearchDelegate {
  final UserController _userController = UserController();
  final InviteController _inviteController = InviteController();
  final String eventId;

  UserSearchDelegate({required this.eventId});

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
                // navigateItem(context, displayUsers[index]);
                _inviteController.sendInvite(eventId, displayUsers[index].id);
              },
            );
          },
        );
      },
    );
  }

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
                // navigateItem(context, displayUsers[index]);
                _inviteController.sendInvite(eventId, displayUsers[index].id);
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
}