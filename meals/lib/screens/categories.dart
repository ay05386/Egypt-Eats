import 'package:flutter/material.dart';
import 'package:meals/Widget/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;
  void _selectCatrgory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => mealsScreen(
                  meals: filteredMeals,
                  title: category.title,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCatrgory(context, category);
            },
          )
      ],
    );
  }
}
