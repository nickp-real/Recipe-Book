class Recipe {
  final String name;
  final String imageUrl;
  final List<dynamic> tags;
  final List<dynamic> instructions;
  final List<dynamic> ingredients;
  String author;

  Recipe(
      this.name, this.imageUrl, this.tags, this.ingredients, this.instructions,
      {this.author = ''});

  Recipe.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        imageUrl = json['imageUrl'] ?? '',
        tags = json['tags'] ?? [],
        instructions = json['instructions'] ?? [],
        ingredients = json['ingredients'] ?? [],
        author = json['author'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'tags': tags,
        'instructions': instructions,
        'ingredients': ingredients,
        'author': author
      };
}
