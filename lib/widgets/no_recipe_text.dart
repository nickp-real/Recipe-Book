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
