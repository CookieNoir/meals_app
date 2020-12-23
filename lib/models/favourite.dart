import 'package:flutter/cupertino.dart';
import 'package:meals/models/meal.dart';

class Favourite extends ChangeNotifier{
  List<Meal> _meals = [];

  void _add(Meal meal) {
    _meals.add(meal);
  }

  void _remove(Meal meal) {
    _meals.remove(meal);
  }

  Meal GetElementById(int index) {
    return _meals[index];
  }

  int Length() {
    return _meals.length;
  }

  bool IsFavourite(String id) {
    final index = _meals.indexWhere((element) => element.id == id);
    return index >= 0;
  }

  void ToggleFavourite(Meal meal) {
    _meals.contains(meal) ? _remove(meal) : _add(meal);
    notifyListeners();
  }
}