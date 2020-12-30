import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/main.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewMealScreen extends StatefulWidget {
  @override
  NewMealScreenState createState() => NewMealScreenState();
}

class NewMealScreenState extends State<NewMealScreen> {
  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();
  final durationController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();
  List<int> categories = new List<int>();
  int category = 1;
  List<String> ingredients = new List<String>();
  List<String> steps = new List<String>();
  Complexity complexity = Complexity.Simple;
  Affordability affordability = Affordability.Affordable;
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool _isValidNumber = false;
  int _duration = 0;

  void addUniqueIdToCategoriesList(int id) {
    if (!categories.contains(id)) categories.add(id);
  }

  void addStringFromControllerToList(
      List<String> list, TextEditingController controller) {
    list.add(controller.text);
    controller.clear();
  }

  bool areAllFieldsFilled() {
    return titleController.text.length > 0 &&
        _isValidNumber &&
        categories.length > 0 &&
        ingredients.length > 0 &&
        steps.length > 0;
  }

  void createNewMeal(BuildContext context) async {
    MealWithoutId mealToPublish = MealWithoutId(
      categories: categories, //list of int
      title: titleController.text, //string
      imageUrl: imageUrlController.text, //string
      ingredients: ingredients, //list of string
      steps: steps, //list of string
      duration: _duration, //int
      complexity: complexity, //int
      affordability: affordability, //int
      isGlutenFree: isGlutenFree, //bool
      isLactoseFree: isLactoseFree, //bool
      isVegan: isVegan, //bool
      isVegetarian: isVegetarian //bool
    );
    final http.Response response = await http.post(
      SERVER_ADDRESS,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mealToPublish.toJson()),
    );
    if (response.statusCode == 201) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }

  Widget buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    // return SwitchListTile.adaptive(
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  Widget namedInputField(
    String label,
    String hint,
    TextEditingController controller,
    TextInputType inputType,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
        keyboardType: inputType,
      ),
    );
  }

  Widget addedCategory(Category category) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      color: category.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              setState(() {
                categories.remove(category.id);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 250,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        namedInputField(
            'Meal title', 'Lasagna', titleController, TextInputType.text),
        namedInputField(
            'Image URL',
            'https://img.icons8.com/ios/452/no-image.png',
            imageUrlController,
            TextInputType.url),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Choose category',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<int>(
                value: category,
                items: CATEGORIES_NAMES
                    .map((value, description) {
                      return MapEntry(
                        value,
                        DropdownMenuItem<int>(
                          value: value,
                          child: Text(description),
                        ),
                      );
                    })
                    .values
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    category = newValue;
                  });
                }),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(
                      color: categories.contains(category)
                          ? Colors.black54
                          : Colors.pink)),
              onPressed: () {
                setState(() {
                  addUniqueIdToCategoriesList(category);
                });
              },
              color:
                  categories.contains(category) ? Colors.black54 : Colors.pink,
              textColor: Color.fromRGBO(255, 254, 229, 1),
              child: Text("Add".toUpperCase(), style: TextStyle(fontSize: 16)),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              for (int i = 0; i < categories.length; ++i)
                addedCategory(CATEGORIES
                    .firstWhere((element) => element.id == categories[i])),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Text('Add some ingredients'),
              namedInputField('Ingredient', '4 Tomatoes', ingredientsController,
                  TextInputType.text),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.pink)),
                onPressed: () {
                  setState(() {
                    addStringFromControllerToList(
                        ingredients, ingredientsController);
                  });
                },
                color: Colors.pink,
                textColor: Color.fromRGBO(255, 254, 229, 1),
                child: Text("Add ingredient".toUpperCase(),
                    style: TextStyle(fontSize: 16)),
              ),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ingredients[index]),
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              setState(() {
                                ingredients.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: ingredients.length,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Text('Add cooking steps'),
              namedInputField(
                  'Step', 'Cut tomatoes', stepsController, TextInputType.text),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(color: Colors.pink)),
                onPressed: () {
                  setState(() {
                    addStringFromControllerToList(steps, stepsController);
                  });
                },
                color: Colors.pink,
                textColor: Color.fromRGBO(255, 254, 229, 1),
                child: Text("Add step".toUpperCase(),
                    style: TextStyle(fontSize: 16)),
              ),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${(index + 1)}'),
                        ),
                        title: Text(
                          steps[index],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              steps.removeAt(index);
                            });
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                  itemCount: steps.length,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: TextFormField(
            controller: durationController,
            decoration: InputDecoration(
              labelText: 'Cooking duration (in minutes)',
              hintText: '15',
            ),
            onChanged: (text) {
              setState(() {
                _duration = int.tryParse(text)??0;
                _isValidNumber = _duration > 0;
              });
            },
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Complexity',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<Complexity>(
                  value: complexity,
                  items: COMPLEXITY_NAMES
                      .map((value, description) {
                        return MapEntry(
                          value,
                          DropdownMenuItem<Complexity>(
                            value: value,
                            child: Text(description),
                          ),
                        );
                      })
                      .values
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      complexity = newValue;
                    });
                  }),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Affordability',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<Affordability>(
                value: affordability,
                items: AFFORDABILITY_NAMES
                    .map((value, description) {
                      return MapEntry(
                        value,
                        DropdownMenuItem<Affordability>(
                          value: value,
                          child: Text(description),
                        ),
                      );
                    })
                    .values
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    affordability = newValue;
                  });
                }),
          ]),
        ),
        SizedBox(
          height: 30,
        ),
        buildSwitchListTile(
          'Gluten-free',
          'Is this a gluten-free meal?',
          isGlutenFree,
          (newValue) {
            setState(() {
              isGlutenFree = newValue;
            });
          },
        ),
        buildSwitchListTile(
          'Lactose-free',
          'Is this a lactose-free meal?',
          isLactoseFree,
          (newValue) {
            setState(() {
              isLactoseFree = newValue;
            });
          },
        ),
        buildSwitchListTile(
          'Vegetarian',
          'Is this a vegetarian meal?',
          isVegetarian,
          (newValue) {
            setState(() {
              isVegetarian = newValue;
            });
          },
        ),
        buildSwitchListTile(
          'Vegan',
          'Is this a vegan meal?',
          isVegan,
          (newValue) {
            setState(() {
              isVegan = newValue;
            });
          },
        ),
        if (areAllFieldsFilled())
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: Colors.pink)),
            onPressed: () {
              setState(() {
                createNewMeal(context);
              });
            },
            color: Colors.pink,
            textColor: Color.fromRGBO(255, 254, 229, 1),
            child:
                Text("Publish".toUpperCase(), style: TextStyle(fontSize: 16)),
          ),
      ],
    );
  }
}
