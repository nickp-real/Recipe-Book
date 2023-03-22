import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/auth.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/add_or_edit/add_or_edit_recipe.dart';
import 'package:receipe_book/pages/instruction/instruction_slide.dart';
import 'package:receipe_book/pages/shopping/shopping_list.dart';
import 'package:receipe_book/services/downloaded_storage.dart';
import 'package:receipe_book/services/storage.dart';
import 'package:receipe_book/widgets/custom_snackbar.dart';

enum MenuPopup { del, share }

class MenuPage<T extends Storage> extends StatelessWidget {
  const MenuPage(
    this.recipe, {
    Key? key,
    this.isDownload = false,
  }) : super(key: key);

  final Recipe recipe;
  final bool isDownload;

  @override
  Widget build(BuildContext context) {
    void handleOnShoppingCartClick() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ShoppingCartScreen(ingredients: recipe.ingredients)),
      );
    }

    void handleOnInstructionClick() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InstruntionSlideScreen(instructions: recipe.instructions)),
      );
    }

    return Consumer<T>(builder: (_, recipes, __) {
      void onDeleteSelect() {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Deleting this recipe?"),
                  content: Text("Are you sure to delete ${recipe.name}?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          recipes.remove(recipe);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackbar.success(
                                  message:
                                      'Delete ${recipe.name} successful.'));
                        },
                        child: const Text("Yes"))
                  ],
                ));
      }

      void onShareSelect() {
        if (Auth().currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.error(
              message: 'Please login first before share.'));
          Navigator.pushNamed(context, '/login');
          return;
        }

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Sharing this recipe?"),
                  content: Text("Are you sure to share ${recipe.name}?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("No")),
                    TextButton(
                        onPressed: () async {
                          try {
                            final shareRecipe = recipe;
                            shareRecipe.author = Auth().currentUser!.email!;
                            await FirebaseFirestore.instance
                                .collection('recipes')
                                .add(shareRecipe.toJson());

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackbar.success(
                                      message:
                                          'Share ${recipe.name} successful.'));
                            }
                          } catch (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackbar.error(
                                    message: 'Share ${recipe.name} failed.'));
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Yes"))
                  ],
                ));
      }

      void handleOnDownloadClick() {
        final res = recipes.add(recipe) as bool;
        ScaffoldMessenger.of(context).showSnackBar(res
            ? CustomSnackbar.success(
                message:
                    "Added ${recipe.name} to 'Downloaded Recipes' successful")
            : CustomSnackbar.error(
                message: 'Failed to add ${recipe.name}, already have it?'));
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(recipe.name),
          actions: !isDownload
              ? [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddOrEditRecipePage<T>(recipe: recipe)));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  PopupMenuButton<MenuPopup>(onSelected: (value) {
                    if (value == MenuPopup.del) {
                      onDeleteSelect();
                    }
                    if (value == MenuPopup.share) {
                      onShareSelect();
                    }
                  }, itemBuilder: (context) {
                    return <PopupMenuEntry<MenuPopup>>[
                      if (!isDownload && T != DownloadedStorage)
                        PopupMenuItem<MenuPopup>(
                          value: MenuPopup.share,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.share_rounded,
                                color: Colors.brown,
                              ),
                              SizedBox(width: 5),
                              Text('Share')
                            ],
                          ),
                        ),
                      PopupMenuItem<MenuPopup>(
                        value: MenuPopup.del,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_rounded,
                              color: Colors.brown,
                            ),
                            SizedBox(width: 5),
                            Text('Delete')
                          ],
                        ),
                      ),
                    ];
                  }),
                ]
              : null,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: MenuImage(recipe: recipe),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

              // button
              !isDownload
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: handleOnShoppingCartClick,
                          icon: const Icon(Icons.shopping_cart_rounded),
                          label: const Text("Shopping"),
                        ),
                        ElevatedButton.icon(
                          onPressed: handleOnInstructionClick,
                          icon: const Icon(Icons.menu_book_rounded),
                          label: const Text("Cooking"),
                        ),
                      ],
                    )
                  : Center(
                      child: ElevatedButton.icon(
                          onPressed: handleOnDownloadClick,
                          icon: const Icon(Icons.download_rounded),
                          label: const Text("Download")),
                    ),
            ],
          ),
        ),
      );
    });
  }
}

class MenuImage extends StatelessWidget {
  const MenuImage({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          recipe.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: ((context, error, stackTrace) =>
              const Center(child: Text("Can't show the image, wrong url?"))),
        ),
      ),
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
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ingredients.isNotEmpty
              ? Wrap(
                  direction: Axis.vertical,
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: ingredients
                      .map((ingredient) => Text(
                            '\u2022 $ingredient',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ))
                      .toList())
              : const Text("No ingredient provided."),
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Instructions",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: instructions.isNotEmpty
              ? Wrap(
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
                      .toList())
              : const Text("No instruction provided."),
        ),
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
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
