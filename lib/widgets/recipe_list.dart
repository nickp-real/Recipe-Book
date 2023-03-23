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
