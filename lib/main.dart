import 'package:flutter/material.dart';
import 'package:meals/models/favourite.dart';
import 'package:meals/models/filters.dart';

import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String SERVER_ADDRESS = 'http://1973507dfd01.ngrok.io/meal';

Future<List<Meal>> fetchMeals() async {
  final response = await http.get(SERVER_ADDRESS);

  if (response.statusCode == 200) {
    var objJson = jsonDecode(response.body)['obj'] as List;
    return objJson.map((e) => Meal.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static Future<List<Meal>> meals;

  static void refreshMealsList() {
    meals = fetchMeals();
  }

  @override
  void initState() {
    super.initState();
    refreshMealsList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<Meal>>(
          create: (context) => meals,
        ),
        ChangeNotifierProvider(
          create: (context) => Favourite(),
        ),
        ChangeNotifierProvider(
          create: (context) => Filters(),
        ),
      ],
      child: MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
        ),
        // home: CategoriesScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(),
          FiltersScreen.routeName: (ctx) => FiltersScreen(),
        },
        // onGenerateRoute: (settings) {
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
        // },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => CategoriesScreen(),
          );
        },
      ),
    );
  }
}
