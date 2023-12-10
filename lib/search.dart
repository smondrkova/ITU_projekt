import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6000,
      height: 640,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Positioned(
            left: 25,
            top: 93,
            child: Container(
              width: 310,
              height: 47,
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
                        'Hľadaj...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 259,
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
          const Positioned(
            left: 25,
            top: 50,
            child: SizedBox(
              width: 229,
              height: 43,
              child: Text(
                'Vyhľadávanie',
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
          Positioned(
            left: 28,
            top: 145,
            child: Container(
              width: 146,
              height: 28,
              padding:
                  const EdgeInsets.only(top: 6, left: 13, right: 8, bottom: 6),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/arrow_icon.svg',
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 102,
                    height: 16,
                    child: Text(
                      'Akýkoľvek dátum',
                      style: TextStyle(
                        color: Color(0xFFEFF0F4),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 180,
            top: 145,
            child: Container(
              width: 146,
              height: 28,
              padding:
                  const EdgeInsets.only(top: 6, left: 13, right: 8, bottom: 6),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/arrow_icon.svg',
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 102,
                    height: 16,
                    child: Text(
                      'Kategória\n',
                      style: TextStyle(
                        color: Color(0xFFEFF0F4),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //         Positioned(
          //             left: 10,
          //             top: 565,
          //             child: Container(
          //                 width: 340,
          //                 height: 65,
          //                 clipBehavior: Clip.antiAlias,
          //                 decoration: ShapeDecoration(
          //                     color: Color(0x2B166D5E),
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(20),
          //                     ),
          //                 ),
          //                 child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                         Container(
          //                             width: 30,
          //                             height: 30,
          //                             clipBehavior: Clip.antiAlias,
          //                             decoration: BoxDecoration(),
          //                             child: Stack(children: [
          //                             ,
          //                             ]),
          //                         ),
          //                         Container(
          //                             width: 32,
          //                             height: 32,
          //                             clipBehavior: Clip.antiAlias,
          //                             decoration: BoxDecoration(),
          //                             child: Stack(children: [
          //                             ,
          //                             ]),
          //                         ),
          //                         Container(
          //                             width: 35,
          //                             height: 35,
          //                             clipBehavior: Clip.antiAlias,
          //                             decoration: BoxDecoration(),
          //                             child: Stack(children: [
          //                             ,
          //                             ]),
          //                         ),
          //                         Container(
          //                             width: 30,
          //                             height: 30,
          //                             clipBehavior: Clip.antiAlias,
          //                             decoration: BoxDecoration(),
          //                             child: Stack(children: [
          //                             ,
          //                             ]),
          //                         ),
          //                     ],
          //                 ),
          //             ),
          //         ),
        ],
      ),
    );
  }
}
