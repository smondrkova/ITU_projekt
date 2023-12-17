/// File: /lib/views/components/favorite_button.dart
/// Project: Evento
///
/// Favorite button component.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itu/controllers/EventController.dart';

class FavoriteButton extends StatefulWidget {
  final String eventId;
  final bool isFavorite;

  const FavoriteButton(
      {Key? key, required this.eventId, required this.isFavorite})
      : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;
  final EventController _eventController = EventController();
  late String svgasset;

  void getFavorite() async {
    isFavorite = await _eventController.isEventFavorite(widget.eventId);
  }

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    getFavorite();
    print('Is favorite: $isFavorite');
    svgasset = isFavorite
        ? 'assets/icons/favorites_filled_icon.svg'
        : 'assets/icons/favorites_bold_icon.svg';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
          if (isFavorite) {
            _eventController.addEventToFavorites(widget.eventId);
            svgasset = 'assets/icons/favorites_filled_icon.svg';
          } else {
            _eventController.removeEventFromFavorites(widget.eventId);
            svgasset = 'assets/icons/favorites_bold_icon.svg';
          }
        });
      },
      child: SizedBox(
        width: 25,
        height: 25,
        child: SvgPicture.asset(svgasset),
      ),
    );
  }
}
