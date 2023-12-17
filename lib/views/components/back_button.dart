/// File: /lib/views/components/back_button.dart
/// Project: Evento
///
/// Back button component.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonWidget extends StatelessWidget {
  final double width;
  final double height;

  BackButtonWidget({this.width = 20.0, this.height = 20.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        width: width,
        height: height,
        child: SvgPicture.asset('assets/icons/left_arrow_icon.svg'),
      ),
    );
  }
}
