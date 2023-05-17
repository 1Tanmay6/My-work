import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';

  Function _toggleFav;
  Function _isFav;

  MealDetailScreen(this._toggleFav, this._isFav);

  Widget _buildSectionTitle(String text, BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headlineMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.45,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle('Ingredients', context),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColorLight),
              padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 1,
                      color: Theme.of(context).primaryColorLight,
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            _buildSectionTitle('Steps', context),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColorLight),
              // padding: EdgeInsets.all(10),
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          child: Text(
                            '# ${index + 1}',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Divider()
                    ]),
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
              _isFav(mealId) ? Icons.favorite : Icons.favorite_border_outlined),
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {
            _toggleFav(mealId);
          }),
    );
  }
}
