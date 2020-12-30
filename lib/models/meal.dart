import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

const Map<Complexity, String> COMPLEXITY_NAMES = {
  Complexity.Simple: "Simple",
  Complexity.Challenging: "Challenging",
  Complexity.Hard: "Hard",
};

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

const Map<Affordability, String> AFFORDABILITY_NAMES = {
  Affordability.Affordable: "Affordable",
  Affordability.Pricey: "Pricey",
  Affordability.Luxurious: "Luxurious",
};

class MealWithoutId {
  final List<int> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const MealWithoutId({
    @required this.categories,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
  });

  Map<String, dynamic> toJson() => {
    'categories': categories,
    'title': title,
    'imageUrl': imageUrl,
    'ingredients': ingredients,
    'steps': steps,
    'duration': duration,
    'complexity': Complexity.values.indexOf(complexity),
    'affordability': Affordability.values.indexOf(affordability),
    'isGlutenFree': isGlutenFree,
    'isLactoseFree': isLactoseFree,
    'isVegan': isVegan,
    'isVegetarian': isVegetarian,
  };
}

class Meal extends MealWithoutId {
  final int id;

  const Meal({
    @required this.id,
    @required categories,
    @required title,
    @required imageUrl,
    @required ingredients,
    @required steps,
    @required duration,
    @required complexity,
    @required affordability,
    @required isGlutenFree,
    @required isLactoseFree,
    @required isVegan,
    @required isVegetarian,
  }) : super(
            categories: categories,
            title: title,
            imageUrl: imageUrl,
            ingredients: ingredients,
            steps: steps,
            duration: duration,
            complexity: complexity,
            affordability: affordability,
            isGlutenFree: isGlutenFree,
            isLactoseFree: isLactoseFree,
            isVegan: isVegan,
            isVegetarian: isVegetarian);

  factory Meal.fromJson(dynamic json) {
    return Meal(
      id: json['id'],
      categories: (json['categories'] as List).map((e) => int.tryParse(e.toString())).toList(),
      title: json['title'],
      imageUrl: json['imageUrl'],
      ingredients: (json['ingredients'] as List).map((e) => e.toString()).toList(),
      steps: (json['steps'] as List).map((e) => e.toString()).toList(),
      duration: json['duration'],
      complexity: Complexity.values[json['complexity']],
      affordability: Affordability.values[json['affordability']],
      isGlutenFree: json['isGlutenFree'],
      isLactoseFree: json['isLactoseFree'],
      isVegan: json['isVegan'],
      isVegetarian: json['isVegetarian'],
    );
  }
}