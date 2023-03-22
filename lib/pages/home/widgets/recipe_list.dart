import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/widgets/no_recipe_text.dart';
import 'package:receipe_book/widgets/recipe_tile.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (_, recipe, __) {
        return FutureBuilder(
            future: recipe.fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Recipe recipe = snapshot.data![index];
                            return RecipeTile(recipe: recipe);
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
