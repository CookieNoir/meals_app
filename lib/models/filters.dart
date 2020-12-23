import 'package:flutter/cupertino.dart';

class Filters extends ChangeNotifier {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  GetFilters() => _filters;

  void SetStateByName(String name, bool value) {
    _filters[name] = value;
    notifyListeners();
  }
}