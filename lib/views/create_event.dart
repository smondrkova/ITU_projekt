import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: 360,
          height: 675,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              const Positioned(
                left: 38,
                top: 50,
                child: SizedBox(
                  width: 267,
                  child: Text(
                    'Vytvor nové podujatie',
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
                left: 42,
                top: 150,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 212,
                        height: 30,
                        child: Text(
                          'Vyber titulný obrázok',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 275,
                        height: 275,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 275,
                                height: 275,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF3B3B3B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 34.83,
                              top: 34.83,
                              child: Container(
                                width: 205.33,
                                height: 205.33,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 25.67,
                                      top: 25.67,
                                      child: Container(
                                        width: 154,
                                        height: 154,
                                        // child: Stack(children: [
                                        // ,
                                        // ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 144,
                        height: 46,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          shadows: [
                            const BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Ďalej',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 50,
                child: Container(
                  width: 25,
                  height: 25,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 2.08,
                        top: 2.08,
                        child: SizedBox(
                          width: 20.83,
                          height: 20.83,
                          child: SvgPicture.asset(
                            'assets/icons/info_icon.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
