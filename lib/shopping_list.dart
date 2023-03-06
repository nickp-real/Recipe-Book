import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  final List<dynamic> ingredients;

  const ShoppingCartScreen({Key? key, required this.ingredients}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}
class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Decoration?> decorations = [];

  @override
  void initState() {
    super.initState();
    decorations = List.generate(widget.ingredients.length, (_) => BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อวัตถุดิบ'),
      ),
      body: ListView.builder(
        itemCount: widget.ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (decorations[index] == null) {
                  decorations[index] = BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  );
                } else {
                  decorations[index] = null;
                }
              });
            },
            child: Container(
              decoration: decorations[index],
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(widget.ingredients[index]),
            ),
          );
        },
      ),
    );
  }
}