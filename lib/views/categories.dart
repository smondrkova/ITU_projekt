// Categories.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itu/models/Category.dart';
import 'package:itu/views/category_detail.dart';
import '../controllers/CategoryController.dart'; // Adjust the import based on your actual file structure

class CategoriesPage extends StatefulWidget {
  final String title;

  const CategoriesPage({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoryController _categoryController = CategoryController();

  Widget buildCategoryListView() {
    return StreamBuilder<List<Category>>(
      stream: _categoryController.getCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        List<Category> categories = snapshot.data!;

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryDetail(category: categories[index]),
                    ),
                  ),
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
                                fit: BoxFit.cover,
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
                              categories[index].name,
                              style: const TextStyle(
                                fontSize: 20,
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
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 740,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          const Positioned(
            left: 25,
            top: 50,
            child: SizedBox(
              width: 153,
              height: 43,
              child: Text(
                'Objavuj',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 90, 0, 30),
            child: buildCategoryListView(),
          ),
        ],
      ),
    );
  }
}
