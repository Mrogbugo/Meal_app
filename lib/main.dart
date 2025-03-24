import 'package:flutter/material.dart';
import 'package:meal_app/screen/categories_screen.dart';
import 'package:meal_app/screen/category_meal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        useMaterial3: false,
      ),
      initialRoute: '/', // ✅ Home screen should be CategoriesScreen
      routes: {
        '/': (ctx) => const CategoriesScreen(), // ✅ Correct home screen
        CategoryMealScreen.routeName: (ctx) => const CategoryMealScreen(),
      },
    );
  }
}
