import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };

  List<Meal> _availableMeals= DUMMY_MEALS;
  List<Meal> _favoriteMeal=[];

  void _setFilters(Map<String,bool> _filtersData){
    setState(() {
      _filters=_filtersData;
      _availableMeals=DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex=_favoriteMeal.indexWhere((meal) => meal.id==mealId);
    if(existingIndex>=0){
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId){
    return _favoriteMeal.any((meal) => meal.id==mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),

        ),
      ),
      routes: {
        '/':(context) => TabsScreen(_favoriteMeal),
        CategoryMealScreen.routName:(context) => CategoryMealScreen(_availableMeals),
        MealDetailScreen.routName:(context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routName:(context) => FiltersScreen(_setFilters,_filters),
      },
      //home: MyHomePage(),
      //home: CategoriesScreen(),
    );
  }
}
