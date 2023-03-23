import 'package:flutter/material.dart';
import 'package:receipe_book/auth.dart';
import 'package:receipe_book/services/downloaded_storage.dart';
import 'package:receipe_book/widgets/appbar.dart';
import 'package:receipe_book/widgets/drawer.dart';
import 'package:receipe_book/widgets/recipe_list.dart';

class DownloadedPage extends StatefulWidget {
  const DownloadedPage({Key? key}) : super(key: key);

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String query = '';

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
              title: 'Downloaded Recipes',
              onSearch: _onSearch,
            ),
            centerTitle: true,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
          ),
          drawer: const MyDrawer(),
          body: RecipeList<DownloadedStorage>(query: query),
        );
      },
    );
  }
}
