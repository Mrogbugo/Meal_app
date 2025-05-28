import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  const CategoryMealScreen(this.availableMeals, {super.key});

  final List<Meal> availableMeals;

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initStatem

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

      // Provide default values to avoid errors
      categoryTitle = routeArgs?['title'] ?? 'Unknown Category';
      final categoryId = routeArgs?['id'] ?? 'Unknown ID';
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals?.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle), // ✅ Safe handling
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
