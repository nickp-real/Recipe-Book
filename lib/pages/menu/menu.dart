import 'package:flutter/material.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/edit/edit_recipe.dart';
import 'package:receipe_book/pages/instruction/instruction_slide.dart';
import 'package:receipe_book/pages/shopping/shopping_list.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(recipe.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditRecipePage()),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'del',
                child: Text('Delete'),
              )
            ];
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    recipe.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.red,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _Category(tags: recipe.tags),
                    const SizedBox(height: 15),
                    _Ingredients(ingredients: recipe.ingredients),
                    const SizedBox(height: 15),
                    _Instructions(instructions: recipe.instructions),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Divider(
              height: 40,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            // Add icons below the divider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen(
                              ingredients: recipe.ingredients)),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.shopping_cart),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstruntionSlideScreen(
                              instructions: recipe.instructions)),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.play_arrow),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Instructions extends StatelessWidget {
  const _Instructions({
    required this.instructions,
  });

  final List<dynamic> instructions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Instructions",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 15),
        Wrap(
          direction: Axis.vertical,
          spacing: 4.0,
          children: instructions
              .asMap()
              .entries
              .map((instruction) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      '${instruction.key + 1}. ${instruction.value}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _Ingredients extends StatelessWidget {
  const _Ingredients({
    required this.ingredients,
  });

  final List<dynamic> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ingredients",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 15),
        Wrap(
            direction: Axis.vertical,
            spacing: 4.0,
            runSpacing: 4.0,
            children: ingredients
                .map((ingredient) => Text(
                      ingredient,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ))
                .toList()),
      ],
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    required this.tags,
  });

  final List<dynamic> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags
          .map((tag) => Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
