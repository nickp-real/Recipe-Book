/// This dart file defines a widget, AddOrEditRecipePage, that provides a form for creating or editing a recipe. The page is built using Flutter and Provider package.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/menu/menu.dart';
import 'package:receipe_book/services/storage.dart';
import 'package:receipe_book/widgets/custom_snackbar.dart';

/// The AddOrEditRecipePage widget is a StatefulWidget that has a recipe property of type Recipe. This widget displays a form that contains several TextFormField widgets that allow the user to enter data for a recipe's name, image URL, tags, ingredients, and instructions.
///
/// The AddOrEditRecipePage widget is responsible for saving the recipe data and updating the storage. It listens to the storage provider using the Consumer widget from the Provider package, which allows it to access the add and edit methods provided by the storage provider. The widget shows a snackbar to the user when the recipe is saved successfully.
///
/// The AddOrEditRecipePage widget has an AppBar with a title that changes based on whether the user is creating or editing a recipe. The AppBar also has a save button that saves the recipe data when clicked. Once the recipe is saved successfully, the user is taken back to the menu page or the edited recipe page, depending on the use case.
///
class AddOrEditRecipePage<T extends Storage> extends StatefulWidget {
  const AddOrEditRecipePage({Key? key, this.recipe}) : super(key: key);

  final Recipe? recipe;

  @override
  State<AddOrEditRecipePage<T>> createState() => _AddOrEditRecipePageState<T>();
}

class _AddOrEditRecipePageState<T extends Storage>
    extends State<AddOrEditRecipePage<T>> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _ingredientControllers = <TextEditingController>[];
  final _tagControllers = <TextEditingController>[];
  final _instructionControllers = <TextEditingController>[];

  @override
  void initState() {
    final recipe = widget.recipe;
    if (recipe != null) {
      _nameController.text = recipe.name;
      _imageUrlController.text = recipe.imageUrl;
      for (var tag in recipe.tags) {
        _tagControllers.add(TextEditingController(text: tag));
      }
      for (var ingredient in recipe.ingredients) {
        _ingredientControllers.add(TextEditingController(text: ingredient));
      }
      for (var instruction in recipe.instructions) {
        _instructionControllers.add(TextEditingController(text: instruction));
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    for (var element in _ingredientControllers) {
      element.dispose();
    }
    for (var element in _tagControllers) {
      element.dispose();
    }
    for (var element in _instructionControllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (_, recipes, __) {
      /// on user click save
      /// if the current state is add, it will add to the RecipeStorage
      /// if the current state is edit, it will set the current recipe to new recipes in RecipeStorage
      void onSave() async {
        final name = _nameController.text;
        final instructions =
            _instructionControllers.map((c) => c.text).toList();
        final imageUrl = _imageUrlController.text;
        final tags = _tagControllers.map((c) => c.text).toList();
        final ingredients = _ingredientControllers.map((c) => c.text).toList();

        final recipe = Recipe(name, imageUrl, tags, ingredients, instructions);

        if (widget.recipe != null) {
          recipes.edit(widget.recipe!, recipe);
        } else {
          recipes.add(recipe);
        }
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.success(
            message:
                "${widget.recipe != null ? "Edit" : "Add"} $name success."));
        Navigator.pop(context);
        if (widget.recipe != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MenuPage<T>(recipe)));
        }
      }

      return Scaffold(
          appBar: AppBar(
            title: Text(widget.recipe != null ? 'Edit Recipe' : 'Add Recipe'),
            actions: [
              IconButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    onSave();
                  },
                  icon: const Icon(Icons.save_rounded))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an image URL';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _ListForm(fields: _tagControllers, label: 'Category'),
                    const SizedBox(height: 16),
                    _ListForm(
                        fields: _ingredientControllers, label: 'Ingredient'),
                    const SizedBox(height: 16),
                    _ListForm(
                        fields: _instructionControllers, label: 'Instruction'),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}

/// The _ListForm widget is a stateful widget that displays a list of TextFormField widgets
/// used for the tags, ingredients, and instructions fields in the
/// AddOrEditRecipePage form. It provides a button to add more fields and a button to remove them.
class _ListForm extends StatefulWidget {
  const _ListForm({
    required this.fields,
    required this.label,
  });

  final List<TextEditingController> fields;
  final String label;

  @override
  State<_ListForm> createState() => _ListFormState();
}

class _ListFormState extends State<_ListForm> {
  /// add a [TextEditingController] to the list.
  void _addField() {
    setState(() {
      widget.fields.add(TextEditingController());
    });
  }

  /// remove a [TextEditingController] at the index from the list.
  void _removeField(int index) {
    setState(() {
      widget.fields.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Column(
          children: widget.fields.asMap().entries.map((field) {
            final index = field.key;
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.fields[index],
                    decoration: InputDecoration(
                        labelText: '${widget.label} ${index + 1}'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ${widget.label}';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _removeField(index),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _addField,
          icon: const Icon(Icons.add),
          label: Text('Add ${widget.label}'),
        ),
      ],
    );
  }
}
