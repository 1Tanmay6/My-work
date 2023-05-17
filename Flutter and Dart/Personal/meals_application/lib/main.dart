import 'package:flutter/material.dart';

import '../Screens/filter_screen.dart';
import '../dummy_data.dart';
import './Screens/tabs_screen.dart';
import '../Screens/error_screen.dart';
import '../Screens/meal_detail_screen.dart';
import '../Screens/categories_screen.dart';
import '../Screens/category_meals_screen.dart';
import '../models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color primarySwatch = Color(0xFF00ab5c);

  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'lactose': false,
    'vegetarian': false
  };

  List<Meal> _avaiableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;
      _avaiableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan']! && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.red,
          canvasColor: Colors.red[100],
          accentColor: Colors.lightGreenAccent[700],
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodySmall: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headlineMedium: TextStyle(
                  fontSize: 19,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  fontSize: 17,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favMeals),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_avaiableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_setFilters, _filters),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => ErrorScreen());
      },
    );
  }
}
