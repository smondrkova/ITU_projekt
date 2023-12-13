import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventDetail extends StatefulWidget {
  final Function navigateToNewPage;
  const EventDetail({required this.navigateToNewPage, Key? key})
      : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 934,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 275,
                    height: 275,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    width: 331,
                    height: 126,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 331,
                          child: Text(
                            'Anna',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Text(
                          '3.1.2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Bobyhall Brno',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '20:00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
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
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 321,
                          child: Text(
                            'Vychutnajte si nezabudnuteľný hudobný zážitok na koncerte speváčky Anny! S jej silným hlasom a jedinečným talentom vám ponúkne večer plný dojímavých balád a hitov. \n\nAnna vás zavedie do sveta hudobného čarovania, kde sa stretnú vášnivé melódie a výnimočný výkon. Zabezpečte si vstupenky a pridajte sa k nám na večer plný hudobnej magie s Annou v ústrednej úlohe! 🎤✨\n\nVstupné: 15€',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 339,
                    height: 52,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 339,
                            height: 52,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 113,
                          top: 13,
                          child: SizedBox(
                            width: 113,
                            height: 25,
                            child: Text(
                              'Vstupenky',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 346,
              top: 50,
              child: SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset('assets/icons/favorites_bold_icon.svg'),
              ),
            ),
            Positioned(
              left: 25,
              top: 50,
              child: GestureDetector(
                onTap: () => widget.navigateToNewPage('CategoryDetailPage'),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/left_arrow_icon.svg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
