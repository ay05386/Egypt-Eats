import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favoirite_meals.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:meals/Widget/main_drawer.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/filters.dart';

//enum Filters { glutenFree, lactoseFree, vegetarian, vegan }
/*
const kInitialfilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false
};
*/
class tabsScreen extends ConsumerStatefulWidget {
  const tabsScreen({super.key});
  @override
  ConsumerState<tabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<tabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> favouriteMeals = [];
  // Map<Filters, bool> _selectedFilters = kInitialfilters;
  /*
  void ToggleFavouriteMeals(Meal meal) {
    final isExisting = favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        favouriteMeals.add(meal);
      });
    }
  }
*/
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(builder: (ctx) => const filtersScreen()));

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((Meal) {
      if (activeFilters[Filters.glutenFree]! && !Meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filters.lactoseFree]! && !Meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filters.vegan]! && !Meal.isVegan) {
        return false;
      }
      if (activeFilters[Filters.vegetarian]! && !Meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = categoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = mealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = "Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: mainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
