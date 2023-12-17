/// File: /lib/views/home.dart
/// Project: Evento
///
/// Home page view.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Category.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/categories.dart';
import 'package:itu/views/category_detail.dart';
import 'package:itu/views/components/event_card_big.dart';
import 'package:itu/views/create_event.dart';
import 'package:itu/views/components/event_card.dart';
import 'package:itu/views/event_detail.dart';
import 'package:itu/views/favorites.dart';
import 'package:itu/views/search.dart';
import 'package:itu/views/user.dart';
import 'package:itu/views/user_invites.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedPage = 0;
  int _selectedCategory = 0;

  late List<Widget> screens;

  _HomePageState() {
    screens = [
      const HomeContent(),
      const SearchPage(),
      const CategoriesPage(
        title: 'Categories',
      ),
      const FavoritesPage(),
      UserPage(
        navigateToNewPage: navigateToNewPage,
      ),
      const CreateEventPage(),
      CategoryDetail(
        //navigateToNewPage: navigateToNewPage,
        category: Category(id: '', name: ''),
      ),
    ];
  }

  int convertPageToIndex(String page) {
    switch (page) {
      case 'HomePage':
        _selectedPage = 0;
        break;
      case 'SearchPage':
        _selectedPage = 1;
        break;
      case 'CategoriesPage':
        _selectedPage = 2;
        break;
      case 'FavoritesPage':
        _selectedPage = 3;
        break;
      case 'UserPage':
        _selectedPage = 4;
        break;
      case 'CreateEventPage':
        _selectedPage = 5;
        break;
      case 'CategoryDetailPage':
        _selectedPage = 6;
        break;
      case 'EventDetailPage':
        _selectedPage = 7;
        break;
      // case 'UserInvitesPage':
      //   _selectedPage = 8;
      //   break;
      default:
        _selectedPage = 0;
        break;
    }

    return _selectedPage;
  }

  void navigateToNewPage(String page) {
    int index = convertPageToIndex(page);
    if (index >= 0 && index < screens.length) {
      setState(() {
        _selectedPage = index;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index >= 0 && index < 5) {
      setState(() {
        _selectedIndex = index;
        _selectedPage = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: screens.elementAt(_selectedPage),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.deepPurple,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    _selectedIndex == 0
                        ? 'assets/icons/home_bold_icon.svg'
                        : 'assets/icons/home_icon.svg',
                    width: 30.0,
                    height: 30.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    _selectedIndex == 1
                        ? 'assets/icons/search_bold_icon.svg'
                        : 'assets/icons/search_icon.svg',
                    width: 32.0,
                    height: 32.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    _selectedIndex == 2
                        ? 'assets/icons/list_bold_icon.svg'
                        : 'assets/icons/list_icon.svg',
                    width: 35.0,
                    height: 35.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    _selectedIndex == 3
                        ? 'assets/icons/favorites_bold_icon.svg'
                        : 'assets/icons/favorites_icon.svg',
                    width: 35.0,
                    height: 35.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    _selectedIndex == 4
                        ? 'assets/icons/user_bold_icon.svg'
                        : 'assets/icons/user_icon.svg',
                    width: 32.0,
                    height: 32.0),
                label: '',
              ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final EventController _eventController = EventController();
  final _currentIndexNotifier = ValueNotifier<int>(0);

  Widget buildEventsListView() {
    return StreamBuilder<List<Event>>(
      stream: _eventController.getEventsForHomePage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        List<Event> events = snapshot.data!;

        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            width: 153,
            height: 43,
            child: Text(
              'Čo je nové',
            ),
          ),
          Column(
            children: [
              CarouselSlider.builder(
                itemCount: 3,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return const EventCardBig();
                },
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7),
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    _currentIndexNotifier.value = index;
                  },
                ),
              ),
            ],
          ),
          CarouselIndicator(
            itemCount: 3,
            currentIndexNotifier: _currentIndexNotifier,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: 287,
            height: 30,
            child: Text(
              'Aktuálne populárne',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 500,
            child: buildEventsListView(),
          ),
        ],
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final ValueNotifier<int> currentIndexNotifier;

  const CarouselIndicator(
      {super.key, required this.itemCount, required this.currentIndexNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == index
                    ? const Color.fromRGBO(255, 254, 254, 0.894)
                    : const Color.fromRGBO(202, 202, 202, 0.4),
              ),
            );
          }),
        );
      },
    );
  }
}
