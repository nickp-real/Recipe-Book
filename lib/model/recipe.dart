class Recipe {
  final String name;
  final String imageUrl;
  final List<dynamic> tags;
  final List<dynamic> instructions;
  final List<dynamic> ingredients;

  Recipe(
      this.name, this.tags, this.instructions, this.ingredients, this.imageUrl);

  Recipe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imageUrl = json['imageUrl'],
        tags = json['tags'],
        instructions = json['instructions'],
        ingredients = json['ingredients'];
}
