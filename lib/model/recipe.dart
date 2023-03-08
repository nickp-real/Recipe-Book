import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recipe {
  final String name;
  final String imageUrl;
  final List<dynamic> tags;
  final List<dynamic> instructions;
  final List<dynamic> ingredients;

  Recipe(
      this.name, this.imageUrl, this.tags, this.ingredients, this.instructions);

  Recipe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imageUrl = json['imageUrl'],
        tags = json['tags'],
        instructions = json['instructions'],
        ingredients = json['ingredients'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'tags': tags,
        'instructions': instructions,
        'ingredients': ingredients
      };
}

class RecipeModel extends ChangeNotifier {
  List<Recipe> _recipes = [];

  Future<List<Recipe>> fetch() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList('recipes') ?? [];
    _recipes = items.map((item) => Recipe.fromJson(jsonDecode(item))).toList();

    return _recipes;
  }

  void add(Recipe recipe) async {
    _recipes.add(recipe);

    _update();
    notifyListeners();
  }

  void remove(Recipe recipe) {
    final index = _recipes.indexOf(recipe);
    _recipes.removeAt(index);

    _update();
    notifyListeners();
  }

  void _update() async {
    final items =
        _recipes.map((recipe) => jsonEncode(recipe.toJson())).toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recipes', items);
  }
}
