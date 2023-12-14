// import 'package:flutter/material.dart';
// import 'package:itu/controllers/CategoryController.dart';

// class CategoriesPage extends StatefulWidget {
//   const CategoriesPage({super.key});

//   @override
//   State<CategoriesPage> createState() => _CategoriesPageState();
//   body: CategoryController().buildCategoryListView(),
// }

// class _CategoriesPageState extends State<CategoriesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 365,
//       height: 1190,
//       clipBehavior: Clip.antiAlias,
//       decoration: const BoxDecoration(color: Colors.black),
//       child: Stack(
//         children: [
//           Positioned(
//             left: 25,
//             top: 98,
//             child: SizedBox(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 345,
//                     height: 132,
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0x3F000000),
//                           blurRadius: 4,
//                           offset: Offset(0, 4),
//                           spreadRadius: 0,
//                         )
//                       ],
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           left: 0,
//                           top: 0,
//                           child: Container(
//                             width: 340,
//                             height: 132,
//                             decoration: ShapeDecoration(
//                               image: const DecorationImage(
//                                 image: AssetImage('assets/placeholder.png'),
//                                 fit: BoxFit.fill,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const Positioned(
//                           left: 27,
//                           top: 16,
//                           child: SizedBox(
//                             width: 189,
//                             height: 48,
//                             child: Text(
//                               'Koncerty',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w700,
//                                 height: 0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 19),
//                 ],
//               ),
//             ),
//           ),
//           const Positioned(
//             left: 25,
//             top: 50,
//             child: SizedBox(
//               width: 153,
//               height: 43,
//               child: Text(
//                 'Objavuj',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w700,
//                   height: 0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Categories.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../controllers/CategoryController.dart'; // Adjust the import based on your actual file structure

class CategoriesPage extends StatefulWidget {
  final String title;

  const CategoriesPage({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      height: 1190,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Positioned(
            left: 25,
            top: 98,
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // sem pojdu category cards
                  GestureDetector(
                    onTap: () => widget.navigateToNewPage('CategoryDetailPage'),
                    child: Container(
                      width: 345,
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
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 340,
                              height: 132,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/placeholder.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 27,
                            top: 16,
                            child: SizedBox(
                              width: 189,
                              height: 48,
                              child: Text(
                                'Koncerty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 19),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 25,
            top: 50,
            child: SizedBox(
              width: 153,
              height: 43,
              child: Text(
                'Objavuj',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
