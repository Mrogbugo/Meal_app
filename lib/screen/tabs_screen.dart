import 'package:flutter/material.dart';
import 'package:meal_app/screen/categories_screen.dart';
import 'package:meal_app/screen/favorites_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(this.favoriteMeals, {super.key});
  final List<Meal> favoriteMeals;
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavouriteScreen(widget.favoriteMeals),
        'title': 'Your Favorites'
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        selectedItemColor: _selectedPageIndex == 0
            ? Color(0xFFFFC107) // Categories
            : Color(0xFFFFC107),
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favourites'),
        ],
      ),
    );
  }
}
