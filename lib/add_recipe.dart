import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddRecipePage extends StatefulWidget {

  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _ingredientControllers = <TextEditingController>[];
  final _tagControllers = <TextEditingController>[];
  final _instructionControllers = <TextEditingController>[];


  void _saveRecipe() async {
    final name = _nameController.text;
    final instructions = _instructionControllers.map((c) => c.text).toList();
    final imageUrl = _imageUrlController.text;
    final tags = _ingredientControllers.map((c) => c.text).toList();
    final ingredients = _ingredientControllers.map((c) => c.text).toList();

    await FirebaseFirestore.instance.collection('recipes').add({
      'name': name,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'tags': tags,
      'ingredients': ingredients,
    });

    Navigator.pop(context);
  }

  void _addTag() {
    setState(() {
      _tagControllers.add(TextEditingController());
    });
  }

  void _removeTag(int index) {
    setState(() {
      _tagControllers.removeAt(index);
    });
  }

  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientControllers.removeAt(index);
    });
  }

  void _addInstruction() {
    setState(() {
      _instructionControllers.add(TextEditingController());
    });
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructionControllers.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
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
              const SizedBox(height: 16),
              Text('Category', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _tagControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _tagControllers[index],
                          decoration:
                          InputDecoration(labelText: 'Category ${index + 1}'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Category';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _removeTag(index),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _addTag,
                icon: Icon(Icons.add),
                label: const Text('Add Category'),
              ),


              const SizedBox(height: 16),
              Text('Ingredient', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _ingredientControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ingredientControllers[index],
                          decoration:
                          InputDecoration(labelText: 'Ingredient ${index + 1}'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Ingredient';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _removeIngredient(index),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _addIngredient,
                icon: Icon(Icons.add),
                label: const Text('Add Ingredient'),
              ),

              const SizedBox(height: 16),
              Text('Instruction', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _instructionControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _instructionControllers[index],
                          decoration:
                          InputDecoration(labelText: 'Instruction ${index + 1}'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Instruction';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _removeInstruction(index),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _addInstruction,
                icon: Icon(Icons.add),
                label: const Text('Add Instruction'),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveRecipe();
                  }
                },
                child: const Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
