import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './dummy_data.dart';
import './Screens/tabs_screen.dart';
import './Screens/category_meals_screen.dart';
import './Screens/categories_screen.dart';
import './Screens/meal_detail_screen.dart';
import './Screens/filters_screen.dart';
import './Models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !element.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !element.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !element.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final exisitingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealId);
    if (exisitingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(exisitingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amberAccent,
        canvasColor: Colors.white, //Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (_) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (_) =>
            MealDetailScreen(_toggleFavorite, _isMealFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilter),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
