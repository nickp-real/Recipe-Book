import 'package:flutter/material.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/menu/menu.dart';

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
