import 'package:flutter/material.dart';
import 'package:meals_application/Widgets/category_item.dart';

import '../dummy_data.dart';
import '../Widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(18),
      children: DUMMY_CATEGORIES
          .map((catDate) => CategoryItem(
              id: catDate.id, title: catDate.title, color: catDate.color))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}
