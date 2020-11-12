import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import 'package:flutter/cupertino.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routName = 'category_meals';

  final List<Meal> availableMeals;

  const CategoryMealScreen(this.availableMeals);


  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryId;
  String categoryTitle;
  List<Meal> categoryMeals;



  @override
  void didChangeDependencies() {
    final routArg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    categoryId = routArg['id'];
    categoryTitle = routArg['title'];
    categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  removeItem(String mealItem) {
    setState(() {
      categoryMeals.removeWhere((element) => element.id == mealItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: categoryMeals[index].id,
              imageUrl: categoryMeals[index].imageUrl,
              title: categoryMeals[index].title,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              removeItem: removeItem,
            );
          },
          itemCount: categoryMeals.length,
        ));
  }
//  Widget test(){
//    return Container(
//      width: double.infinity,
//      height: 150,
//      decoration: BoxDecoration(
//        image: DecorationImage(
//            image: NetworkImage(categoryMeals[index].imageUrl),
//            fit: BoxFit.cover,
//            colorFilter: ColorFilter.mode(
//                Colors.black.withOpacity(0.5), BlendMode.darken)),
//        boxShadow: [
//          BoxShadow(
//            color: Colors.black.withOpacity(0.5),
//            spreadRadius: 2,
//            blurRadius: 1,
//          )
//        ],
//      ),
//      child: Center(
//          child: Text(
//            categoryMeals[index].title,
//            style: TextStyle(
//              color: Colors.white,
//              fontSize: 18,
//              fontWeight: FontWeight.bold,
//            ),
//          )),
//    );
//  }

}
