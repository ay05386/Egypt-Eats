import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class favoriteMalsNotifier extends StateNotifier<List<Meal>> {
  favoriteMalsNotifier() : super([]);
  bool toggleMealsFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<favoriteMalsNotifier, List<Meal>>((ref) {
  return favoriteMalsNotifier();
});
