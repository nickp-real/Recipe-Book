import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/recipe.dart';

/// This class provided search function
/// [query] for frontend search
/// [firebaseQuery] for backend search in firebase
class Search {
  /// Search with string matching.
  /// The search included name, tags, and author.
  static query(List<Recipe> data, String query) {
    if (query.isEmpty) return data;
    return data.where((recipe) =>
        recipe.name.contains(query) ||
        recipe.tags.any((tag) => tag.toString().contains(query)) ||
        recipe.author.contains(query));
  }

  /// The search included only name.
  /// Firebase can't do full-text search.
  static Stream<QuerySnapshot<Map<String, dynamic>>> firebaseQuery(
      String searchText) {
    if (searchText.isEmpty) {
      return FirebaseFirestore.instance.collectionGroup('recipes').snapshots();
    }
    return FirebaseFirestore.instance
        .collectionGroup('recipes')
        .where('name', isGreaterThanOrEqualTo: searchText)
        .where('name', isLessThan: '${searchText}z')
        .snapshots();
  }
}
