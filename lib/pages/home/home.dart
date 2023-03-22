import 'package:flutter/material.dart';
import 'package:receipe_book/auth.dart';
import 'package:receipe_book/pages/add_or_edit/add_or_edit_recipe.dart';
import 'package:receipe_book/widgets/appbar.dart';
import 'package:receipe_book/widgets/drawer.dart';

import 'widgets/recipe_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateToAddRecipePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddOrEditRecipePage()),
    );
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
                onSearch: (value) {}),
            centerTitle: true,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
          ),
          drawer: const MyDrawer(),
          body: const RecipeList(),
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToAddRecipePage,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
