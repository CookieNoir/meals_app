import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final Color color;

  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      color: json['color'],
    );
  }
}

const Map<int, String> CATEGORIES_NAMES = {
  1: 'Italian',
  2: 'Quick & Easy',
  3: 'Hamburgers',
  4: 'German',
  5: 'Light & Lovely',
  6: 'Exotic',
  7: 'Breakfast',
  8: 'Asian',
  9: 'French',
  10: 'Summer',
};

const CATEGORIES = const [
  Category(
    id: 1,
    title: 'Italian',
    color: Colors.purple,
  ),
  Category(
    id: 2,
    title: 'Quick & Easy',
    color: Colors.red,
  ),
  Category(
    id: 3,
    title: 'Hamburgers',
    color: Colors.orange,
  ),
  Category(
    id: 4,
    title: 'German',
    color: Colors.amber,
  ),
  Category(
    id: 5,
    title: 'Light & Lovely',
    color: Colors.blue,
  ),
  Category(
    id: 6,
    title: 'Exotic',
    color: Colors.green,
  ),
  Category(
    id: 7,
    title: 'Breakfast',
    color: Colors.lightBlue,
  ),
  Category(
    id: 8,
    title: 'Asian',
    color: Colors.lightGreen,
  ),
  Category(
    id: 9,
    title: 'French',
    color: Colors.pink,
  ),
  Category(
    id: 10,
    title: 'Summer',
    color: Colors.teal,
  ),
];