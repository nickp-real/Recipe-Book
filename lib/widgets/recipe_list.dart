import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/services/storage.dart';
import 'package:receipe_book/widgets/no_recipe_text.dart';
import 'package:receipe_book/widgets/recipe_tile.dart';

class RecipeList<T extends Storage> extends StatelessWidget {
  const RecipeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, recipes, __) {
        return FutureBuilder(
            future: recipes.fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Recipe recipe = snapshot.data![index];
                            return RecipeTile<T>(recipe);
                          },
                        ))
                    : const Center(
                        child: NoRecipeText(
                        title: "No recipes yet",
                        subtext: "Creative recipes need a book for them.",
                      ));
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}
