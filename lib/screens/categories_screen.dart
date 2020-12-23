import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:provider/provider.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: context.watch<List<Category>>()
          .map(
            (catData) => CategoryItem(
                  catData.id,
                  catData.title,
                  catData.color,
                ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
