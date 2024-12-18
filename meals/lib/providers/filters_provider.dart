import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/tabs.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false
        });
  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((Meal) {
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
});
