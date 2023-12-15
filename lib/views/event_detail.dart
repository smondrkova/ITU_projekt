import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/reviews.dart';
import 'package:itu/views/send_invite.dart';

class EventDetail extends StatefulWidget {
  //final Function navigateToNewPage;
  final Event event;

  const EventDetail({required this.event, Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  bool isFavorite = false;

  Widget buildButton(String text, Color color, [Widget? page]) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page ?? const Placeholder(),
        ),
      ),
      child: SizedBox(
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
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  SizedBox(
                    //width: 331,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320,
                          child: Text(
                            widget.event.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(widget.event.date_time),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          widget.event.location,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(widget.event.date_time),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 321,
                          child: Text(
                            widget.event.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  widget.event.ticketSellLink != ''
                      ? buildButton("Vstupenky", Colors.white, null)
                      : const SizedBox.shrink(),
                  const SizedBox(height: 8),
                  if (DateTime.now().isBefore(widget.event.date_time))
                    buildButton(
                        "Poslať pozvánku",
                        const Color.fromARGB(255, 122, 60, 194),
                        const SendInvitePage()),
                  if (DateTime.now().isAfter(widget.event.date_time))
                    buildButton(
                        "Recenzie", Colors.deepPurple, const ReviewsPage()),
                ],
              ),
            ),
            Positioned(
              left: 346,
              top: 50,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    isFavorite
                        ? 'assets/icons/favorites_filled_icon.svg'
                        : 'assets/icons/favorites_bold_icon.svg',
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
