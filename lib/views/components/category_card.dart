/// File: /lib/views/components/category_card.dart
/// Project: Evento
///
/// Category card component used on discover/categories page.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'package:flutter/material.dart';
import 'package:itu/models/Category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function navigateToNewPage;

  const CategoryCard(
      {super.key, required this.category, required this.navigateToNewPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToNewPage(6),
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
                  image: DecorationImage(
                    image: category.photoUrl != null
                        ? AssetImage(category.photoUrl!)
                        : const AssetImage('assets/placeholder.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 27,
              top: 16,
              child: SizedBox(
                width: 189,
                height: 48,
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
