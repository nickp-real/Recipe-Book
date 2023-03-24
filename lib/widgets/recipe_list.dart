/// A widget that displays a list of recipes based on a query.
///
/// This widget takes a type parameter T which extends the Storage class
/// and is used to specify the type of storage to fetch recipes from.
/// The query parameter is used to filter the recipes displayed based on
/// recipe name, tags, and author.
///
/// This widget uses the Consumer widget from the provider package to
/// listen for changes in the recipes and rebuild the UI accordingly.
/// The FutureBuilder widget is used to fetch the recipes from storage.
/// Once the future is complete, the query is applied to the list of recipes
/// to filter them, and a ListView is created to display the filtered
/// recipes using the RecipeTile widget.
/// If there are no recipes to display, a NoRecipeText widget is shown with
/// a message depending on whether a query is applied or not.
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/services/storage.dart';
import 'package:receipe_book/widgets/no_recipe_text.dart';
import 'package:receipe_book/widgets/recipe_tile.dart';

class RecipeList<T extends Storage> extends StatelessWidget {
  const RecipeList({super.key, this.query = ''});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, recipes, __) {
        return FutureBuilder(
            future: recipes.fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final queryData = query.isEmpty
                    ? snapshot.data!
                    : snapshot.data!.where((recipe) =>
                        recipe.name.contains(query) ||
                        recipe.tags
                            .any((tag) => tag.toString().contains(query)) ||
                        recipe.author.contains(query));

                return queryData.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: queryData.length,
                          itemBuilder: (BuildContext context, int index) {
                            Recipe recipe = snapshot.data![index];
                            return RecipeTile<T>(recipe);
                          },
                        ))
                    : query.isEmpty
                        ? const Center(
                            child: NoRecipeText(
                            title: "No recipes yet",
                            subtext: "Creative recipes need a book for them.",
                          ))
                        : const Center(
                            child: NoRecipeText(
                            title: "Blank page!",
                            subtext:
                                "Can't find the recipe you are looking for.",
                          ));
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}
