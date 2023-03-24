import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class represents a storage that saves downloaded recipes using SharedPreferences.
///
/// It implements the Storage interface and notifies its listeners when there is a change in the data.
///
/// This class has a private field _recipes that holds a list of Recipe objects.
///
/// When the fetch method is called, it gets the list of saved recipes from SharedPreferences and
/// populates _recipes with them.
///
/// The add method adds a new recipe to _recipes and saves the updated list in SharedPreferences.
///
/// The edit method finds the index of the old recipe in _recipes, replaces it with the new recipe,
/// and saves the updated list in SharedPreferences.
///
/// The remove method finds the index of the recipe to be removed in _recipes, removes it,
/// and saves the updated list in SharedPreferences.
///
/// The _update method converts each recipe in _recipes to a JSON string and saves the list of strings
/// in SharedPreferences. This method is called whenever there is a change in _recipes.
class DownloadedStorage extends ChangeNotifier implements Storage {
  List<Recipe> _recipes = [];

  @override
  Future<List<Recipe>> fetch() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList('downloaded') ?? [];
    _recipes = items.map((item) => Recipe.fromJson(jsonDecode(item))).toList();

    return _recipes;
  }

  @override
  bool add(Recipe recipe) {
    if (_recipes
        .any((oldRecipe) => jsonEncode(oldRecipe) == jsonEncode(recipe))) {
      return false;
    }

    _recipes.add(recipe);
    _update();
    notifyListeners();
    return true;
  }

  @override
  void edit(Recipe oldRecipe, Recipe newRecipe) {
    // to compare the object, change it to string because of reference diff
    final index = _recipes
        .indexWhere((recipe) => jsonEncode(recipe) == jsonEncode(oldRecipe));
    _recipes[index] = newRecipe;

    _update();
    notifyListeners();
  }

  @override
  void remove(Recipe recipe) {
    final index = _recipes.indexOf(recipe);
    _recipes.removeAt(index);

    _update();
    notifyListeners();
  }

  Future<void> _update() async {
    final items =
        _recipes.map((recipe) => jsonEncode(recipe.toJson())).toList();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('downloaded', items);
  }
}
