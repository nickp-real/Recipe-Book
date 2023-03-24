/// A widget that displays a title and subtext when there are no recipes available.
///
/// This widget takes in a required [title] and [subtext] as parameters to display the text.
/// It is designed to be used when there are no recipes available to display in a list or grid.
import 'package:flutter/material.dart';

class NoRecipeText extends StatelessWidget {
  const NoRecipeText({super.key, required this.title, required this.subtext});
  final String title;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Text(subtext, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
