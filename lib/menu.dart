import 'package:flutter/material.dart';
import 'shopping_list.dart';
import 'instruction_slide.dart';
import 'edit_recipe.dart';
class MenuPage extends StatefulWidget {
  final String name;
  final List<dynamic> tags;
  final String imageUrl;
  final List<dynamic> ingredients;
  final List<dynamic> instructions;


  const MenuPage({
    Key? key,
    required this.name,
    required this.tags,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
  }) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
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
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List.generate(
                    widget.tags.length,
                        (index) => Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.tags[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Ingredients",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 15),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: List.generate(
                    widget.ingredients.length,
                        (index) => Container(
                      child: Text(
                        widget.ingredients[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Instructions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 15),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 4.0,
                  children: List.generate(
                    widget.tags.length,
                        (index) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(

                        '${index + 1}.' + widget.instructions[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  height: 40,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ],
          ),

          // Add icons below the divider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingCartScreen(ingredients: widget.ingredients)),
                  );
                },
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstruntionSlideScreen(instructions: widget.instructions)),
                  );
                },
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}