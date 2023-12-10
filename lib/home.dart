import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itu/categories.dart';
import 'package:itu/favorites.dart';
import 'package:itu/search.dart';
import 'package:itu/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const HomeContent(),
    const SearchPage(),
    const CategoriesPage(),
    const FavoritesPage(),
    const UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0), // Add some padding
        decoration: BoxDecoration(
          color: Colors.deepPurple, // Set the color to purple
          borderRadius: BorderRadius.circular(20.0), // Add rounded corners
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
                    width: 30.0,
                    height: 30.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    _selectedIndex == 4
                        ? 'assets/icons/user_bold_icon.svg'
                        : 'assets/icons/user_icon.svg',
                    width: 30.0,
                    height: 30.0),
                label: '',
              ),
            ],
            showSelectedLabels: false, // <-- HERE
            showUnselectedLabels: false, // <-- AND HERE
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 153,
              height: 43,
              child: Text(
                'Čo je nové',
              ),
            ),
            Container(
              width: 314,
              height: 186,
              padding: const EdgeInsets.only(
                top: 116,
                left: 30,
                right: 50,
                bottom: 14,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/placeholder.png'),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
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
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 234,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 152,
                          child: Text(
                            'Najlepšia párty',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 234,
                          child: Text(
                            '6.12.2023',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 234,
                          child: Text(
                            'Fléda',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFEFF0F4),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        color: Color(0x7FEFF0F4),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        color: Color(0x7FEFF0F4),
                        shape: OvalBorder(),
                      ),
                    ),
                  ],
                ),
              ),
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
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 314,
              height: 132,
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
                    left: 149,
                    top: 0,
                    child: Container(
                      width: 165,
                      height: 132,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF3B3B3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 149,
                      height: 132,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 162,
                    top: 42.31,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 152,
                          child: Text(
                            'Burger fest',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 115,
                          child: Text(
                            '25.11.2023',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 148,
                          child: Text(
                            'Námestie Svobody',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
