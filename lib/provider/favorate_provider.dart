import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';

class FavorateMealsNotifier extends StateNotifier<List<Meal>> {
  //initial value for our favMeals
  FavorateMealsNotifier() : super([]);

// method to  edit(add or to remove) the initiated value in favMeals
  bool toggleMealFavStatus(Meal meal) {
    final mealIsFavorate = state.contains(meal);

    if (mealIsFavorate) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
    //add the meal if fav
    //remove the meal if not fav
  }
}

final favorateMealProvider =
    StateNotifierProvider<FavorateMealsNotifier, List<Meal>>((ref) {
  return FavorateMealsNotifier();
});
