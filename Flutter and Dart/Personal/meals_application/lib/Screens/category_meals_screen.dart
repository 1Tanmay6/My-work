import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Widgets/meal_item.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/categories-meal';

  final List<Meal> avaiableMeals;

  CategoryMealScreen(this.avaiableMeals);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var isInitdataLoaded = false;

  @override
  void didChangeDependencies() {
    if (!isInitdataLoaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.avaiableMeals.where(
        (meal) {
          return meal.categories.contains(categoryId);
        },
      ).toList();
      isInitdataLoaded = true;
    }

    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          var data = displayedMeals![index];
          return MealItem(
            id: data.id,
            title: data.title,
            imageUrl: data.imageUrl,
            duration: data.duration,
            complexity: data.complexity,
            affordability: data.affordability,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
