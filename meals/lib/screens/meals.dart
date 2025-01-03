import 'package:flutter/material.dart';
import 'package:meals/main.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/Widget/meal_item.dart';
import 'package:meals/screens/meals_details.dart';

class mealsScreen extends StatelessWidget {
  const mealsScreen({
    super.key,
    required this.meals,
    this.title,
  });
  final String? title;
  final List<Meal> meals;

  void selectMeal(Meal meal, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsDetails(
              title: meal.title,
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          selectMeal(meal, context);
        },
      ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nothing here",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Try choosing another category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
