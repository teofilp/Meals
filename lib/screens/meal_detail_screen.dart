import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;

    final meal = DUMMY_MEALS.firstWhere((ml) => ml.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle("Ingredients", context),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index])),
                );
              },
              itemCount: meal.ingredients.length,
            ),
          ),
          buildSectionTitle("Steps", context),
          buildContainer(
            ListView.builder(
              itemCount: meal.steps.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(child: Text('#${(index + 1)}')),
                      title: Text(
                        meal.steps.elementAt(index),
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
