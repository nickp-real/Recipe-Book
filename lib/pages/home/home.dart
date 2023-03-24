/// This file contains the HomePage widget, which is responsible for displaying a list of recipes of your own recipe
///
/// that can be searched through using a search bar.
/// The Recipe that show in this page is came from the local storage
/// your own Recipe will show on this page
import 'package:flutter/material.dart';
import 'package:receipe_book/auth.dart';
import 'package:receipe_book/pages/add_or_edit/add_or_edit_recipe.dart';
import 'package:receipe_book/services/recipe_storage.dart';
import 'package:receipe_book/widgets/appbar.dart';
import 'package:receipe_book/widgets/drawer.dart';
import 'package:receipe_book/widgets/recipe_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String query = '';
  /// this function will be used after the user click on add icon and then it will navigate user to the AddOrEditRecipePage
  void _navigateToAddRecipePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const AddOrEditRecipePage<RecipeStorage>()),
    );
  }
  /// onSearch function can be use to search your own Recipe
  void _onSearch(String searchText) {
    setState(() {
      query = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: MainAppBar(
              drawerKey: _scaffoldKey,
              title: 'Your Recipes',
              onSearch: _onSearch,
            ),
            centerTitle: true,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
          ),
          drawer: const MyDrawer(),
          body: RecipeList<RecipeStorage>(query: query),
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToAddRecipePage,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
