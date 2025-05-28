import 'package:flutter/material.dart';
import 'package:meal_app/screen/category_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem(this.id, this.title, this.color, {super.key});

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          selectCategory(context), // ✅ Now correctly calls the function
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withAlpha((0.7 * 255).toInt()), // ✅ Corrected opacity usage
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // ✅ Ensured good contrast
              ),
        ),
      ),
    );
  }
}
