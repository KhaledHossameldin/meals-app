import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Widgets/meal_item.dart';
import '../Models/meal.dart';

class FavourtiesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavourtiesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('No favourites yet'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
            // removeItem: _removeMeal,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
