import 'package:flutter/material.dart';
import 'package:itu/controllers/CategoryController.dart';
import 'package:itu/models/Category.dart';
import 'package:itu/models/Event.dart';

class CategoryDropdownMenu extends StatefulWidget {
  final Event event;
  const CategoryDropdownMenu({super.key, required this.event});

  @override
  State<CategoryDropdownMenu> createState() => _CategoryDropdownMenuState();
}

class _CategoryDropdownMenuState extends State<CategoryDropdownMenu> {
  final CategoryController _categoryController = CategoryController();
  String? categoryName;

  void getCategoryName(String categoryId) async {
    categoryName = await _categoryController.getCategoryNameById(categoryId);
    print('Category name: $categoryName');
  }

  @override
  void initState() {
    super.initState();
    getCategoryName(widget.event.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    print('Widget event category id: ${widget.event.categoryId}');
    getCategoryName(widget.event.categoryId);

    return StreamBuilder<List<Category>>(
      stream: _categoryController.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error loading categories');
        } else {
          List<Category> categories = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: DropdownButtonFormField<String>(
              value: categoryName,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: categoryName,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(110, 255, 255, 255),
                ),
              ),
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.name,
                  child: Text(category.name,
                      style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                widget.event.categoryId = newValue!;
              },
              onSaved: (String? value) {
                widget.event.categoryId = value!;
              },
            ),
          );
        }
      },
    );
  }
}
