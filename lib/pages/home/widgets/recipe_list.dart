import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/menu/menu.dart';

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
                    : const Center(child: NoRecipeText());
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}

class NoRecipeText extends StatelessWidget {
  const NoRecipeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("No recipes yet",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Text("Creative recipes need a book for them.",
            style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    void toMenu(Recipe recipe) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(
            recipe: recipe,
          ),
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(recipe.imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        title: Text(
          recipe.name,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recipe.tags
              .map((tag) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      tag,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
              .toList(),
        ),
        onTap: () => toMenu(recipe),
      ),
    );
  }
}
