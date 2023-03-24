import 'package:flutter/material.dart';
import 'package:receipe_book/model/recipe.dart';
/// This abstract class defines the methods that must be implemented by any class that serves as a storage for recipes.
abstract class Storage extends ChangeNotifier {
  Future<List<Recipe>> fetch();

  void add(Recipe recipe);

  void edit(Recipe oldRecipe, Recipe newRecipe);

  void remove(Recipe recipe);
}
