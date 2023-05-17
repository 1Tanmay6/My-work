import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorite_screem.dart';
import '../Widgets/main_drawer.dart';
import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() => _TabScreenState();

  final List<Meal> favMeals;

  TabScreen(this.favMeals);
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>>? _pages;
  var _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoriteScreen(widget.favMeals), 'title': 'Favorites'}
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
        title: Text(_pages![_selectedPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.red[50],
          selectedItemColor: Colors.lightGreenAccent[700],
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite_outline),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
