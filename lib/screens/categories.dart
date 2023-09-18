import 'package:flutter/material.dart';
import 'package:multiple_screen/widgets/category_Grid_Iterm.dart';
import '../models/meal.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import './meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      // required this.onToggleFavorate,
      required this.availableMeals});

  // final void Function(Meal meal) onToggleFavorate;
  final List<Meal> availableMeals;

  void _selectCatrgory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
        // onToggleFavorite: onToggleFavorate,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        // we can use maping approach
        for (final category in availableCategories)
          // CategoryGridIterm(
          //   category: category,
          // )
          CategoryGridIterm(
            category: category,
            onSelectCategory: () {
              _selectCatrgory(context, category);
            },
          )
      ],
    );
  }
}
