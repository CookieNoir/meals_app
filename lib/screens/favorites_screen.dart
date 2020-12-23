import 'package:flutter/material.dart';
import 'package:meals/models/favourite.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen();

  @override
  Widget build(BuildContext context) {
    final Favourite favourite = context.watch<Favourite>();
    if (favourite == null) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          Meal meal = favourite.GetElementById(index);
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            affordability: meal.affordability,
            complexity: meal.complexity,
          );
        },
        itemCount: favourite.Length(),
      );
    }
  }
}
