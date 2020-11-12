import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;

  FavoritesScreen(this.favoriteMeal);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeal.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'You have no favorites yet - start adding some!',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: widget.favoriteMeal[index].id,
              imageUrl: widget.favoriteMeal[index].imageUrl,
              title: widget.favoriteMeal[index].title,
              duration: widget.favoriteMeal[index].duration,
              affordability: widget.favoriteMeal[index].affordability,
              complexity: widget.favoriteMeal[index].complexity,
            );
          },
          itemCount: widget.favoriteMeal.length,
        ),
      );
    }
  }
}
