import 'package:flutter/material.dart';
/// The ShoppingCartScreen is use to display the Ingredients List of the Recipe and let the user can click each Ingredient to check that they already had that Ingredient or not
/// After tapped in the Ingredient , the color will change to the Green that show that you already had that ingredient
class ShoppingCartScreen extends StatefulWidget {
  final List<dynamic> ingredients;

  const ShoppingCartScreen({Key? key, required this.ingredients})
      : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    colors = List.generate(widget.ingredients.length, (_) => Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: widget.ingredients.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.ingredients.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (colors[index] == Colors.white) {
                                    colors[index] = Colors.green.shade400;
                                  } else {
                                    colors[index] = Colors.white;
                                  }
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 2,
                                color: colors[index],
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(widget.ingredients[index],
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16)),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Finish"))
                ],
              ),
            )
          : const Center(child: Text("No ingredient provided.")),
    );
  }
}
