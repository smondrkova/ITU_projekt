// import 'package:flutter/material.dart';

// class BottomBarWidget extends StatelessWidget {
//   const BottomBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0), // Add some padding
//       decoration: BoxDecoration(
//         color: Colors.deepPurple, // Set the color to purple
//         borderRadius: BorderRadius.circular(20.0), // Add rounded corners
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(
//           canvasColor: Colors.deepPurple,
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           type: BottomNavigationBarType.fixed,
//           elevation: 0.0,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                   _selectedIndex == 0
//                       ? 'assets/icons/home_bold_icon.svg'
//                       : 'assets/icons/home_icon.svg',
//                   width: 30.0,
//                   height: 30.0),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                   _selectedIndex == 1
//                       ? 'assets/icons/search_bold_icon.svg'
//                       : 'assets/icons/search_icon.svg',
//                   width: 32.0,
//                   height: 32.0),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                   _selectedIndex == 2
//                       ? 'assets/icons/list_bold_icon.svg'
//                       : 'assets/icons/list_icon.svg',
//                   width: 35.0,
//                   height: 35.0),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                   _selectedIndex == 3
//                       ? 'assets/icons/favorites_bold_icon.svg'
//                       : 'assets/icons/favorites_icon.svg',
//                   width: 30.0,
//                   height: 30.0),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                   _selectedIndex == 4
//                       ? 'assets/icons/user_bold_icon.svg'
//                       : 'assets/icons/user_icon.svg',
//                   width: 30.0,
//                   height: 30.0),
//               label: '',
//             ),
//           ],
//           showSelectedLabels: false, // <-- HERE
//           showUnselectedLabels: false, // <-- AND HERE
//         ),
//       ),
//     );
//   }
// }
