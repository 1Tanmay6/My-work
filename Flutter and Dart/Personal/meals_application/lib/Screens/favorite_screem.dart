import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../Widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal>? favMeals;

  FavoriteScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if (favMeals!.isEmpty) {
      return Center(child: Text('You have no favorites yet'));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          var data = favMeals![index];
          return MealItem(
            id: data.id,
            title: data.title,
            imageUrl: data.imageUrl,
            duration: data.duration,
            complexity: data.complexity,
            affordability: data.affordability,
          );
        },
        itemCount: favMeals!.length,
      );
    }
  }
}
