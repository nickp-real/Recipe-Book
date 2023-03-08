import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _ingredientControllers = <TextEditingController>[];
  final _tagControllers = <TextEditingController>[];
  final _instructionControllers = <TextEditingController>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Recipe'),
        ),
        body: Consumer<RecipeModel>(
          builder: (_, recipes, __) {
            void saveRecipe() async {
              final name = _nameController.text;
              final instructions =
                  _instructionControllers.map((c) => c.text).toList();
              final imageUrl = _imageUrlController.text;
              final tags = _tagControllers.map((c) => c.text).toList();
              final ingredients =
                  _ingredientControllers.map((c) => c.text).toList();

              final recipe =
                  Recipe(name, imageUrl, tags, instructions, ingredients);
              recipes.add(recipe);

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Add $name success.")));

              // await FirebaseFirestore.instance.collection('recipes').add({
              //   'name': name,
              //   'instructions': instructions,
              //   'imageUrl': imageUrl,
              //   'tags': tags,
              //   'ingredients': ingredients,
              // }).then((_) => Navigator.pop(context));
              Navigator.pop(context);
            }

            return SingleChildScrollView(
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
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ListForm(fields: _tagControllers, name: 'Category'),
                      const SizedBox(height: 16),
                      ListForm(
                          fields: _ingredientControllers, name: 'Ingredient'),
                      const SizedBox(height: 16),
                      ListForm(
                          fields: _instructionControllers, name: 'Instruction'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveRecipe();
                          }
                        },
                        child: const Text('Save Recipe'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class ListForm extends StatefulWidget {
  const ListForm({required this.fields, required this.name, super.key});

  final List<TextEditingController> fields;
  final String name;

  @override
  State<ListForm> createState() => _ListFormState();
}

class _ListFormState extends State<ListForm> {
  void _addField() {
    setState(() {
      widget.fields.add(TextEditingController());
    });
  }

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
        Text(widget.name, style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.fields.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.fields[index],
                    decoration: InputDecoration(
                        labelText: '${widget.name} ${index + 1}'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ${widget.name}';
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
          },
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _addField,
          icon: const Icon(Icons.add),
          label: Text('Add ${widget.name}'),
        ),
      ],
    );
  }
}
