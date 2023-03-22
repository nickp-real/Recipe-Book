import 'package:flutter/material.dart';
import 'package:receipe_book/model/recipe.dart';

abstract class Storage extends ChangeNotifier {
  Future<List<Recipe>> fetch();

  void add(Recipe recipe);

  void edit(Recipe oldRecipe, Recipe newRecipe);

  void remove(Recipe recipe);
}
