import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_screen/screens/categories.dart';
import 'package:multiple_screen/screens/meals.dart';
import '../provider/favorate_provider.dart';
import '../provider/filters_provider.dart';
import '../widgets/main_drawer.dart';
import '../screens/filters.dart';
// import '../models/meal.dart';

const KInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;
  // final List<Meal> _favorateMealStatus = [];
  // Map<Filter, bool> _selectedFilters = KInitialFilters;

  // snackbar function
  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

// //fun to add or remove meal as fav
//   void _toggleMealFavStatus(Meal meal) {
//     // checking if the meal exist as fav or not
//     final isExisting = _favorateMealStatus.contains(meal);
//     //   final void Function(Meal meal) onToggleFavorate;

// // add or remove the meal from fav
//     if (isExisting) {
//       setState(() {
//         _favorateMealStatus.remove(meal);
//       });
//       _showInfoMessage('meal removed from favorate');
//     } else {
//       setState(() {
//         _favorateMealStatus.add(meal);
//       });
//       _showInfoMessage('meal add to favorate');
//     }
//   }

  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifer) async {
    Navigator.of(context).pop();
    if (identifer == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
      // print(result);
      // setState(() {
      //   _selectedFilters = result ?? KInitialFilters;
      // });
    }
    // else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(FilterMealsProvider);

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';
    if (_selectPageIndex == 1) {
      final favorateMeals = ref.watch(favorateMealProvider);
      activePage = MealsScreen(
        meals: favorateMeals,
        // onToggleFavorite: _toggleMealFavStatus,
      );
      activePageTitle = 'Favorates ';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectPageIndex,
        onTap: selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'meals'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favorate')
        ],
      ),
    );
  }
}
