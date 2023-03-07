import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/add/add_recipe.dart';
import 'package:receipe_book/pages/menu/menu.dart';

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
      MaterialPageRoute(builder: (context) => const AddRecipePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: MainAppBar(drawerKey: _scaffoldKey),
        centerTitle: true,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(),
      body: RecipeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddRecipePage,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  const RecipeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collectionGroup('recipes').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe data = Recipe.fromJson(
                snapshot.data!.docs[index].data() as Map<String, dynamic>);
            final tags = data.tags;
            final image = data.imageUrl;
            return RecipeTile(data: data, image: image, tags: tags);
          },
        );
      },
    );
  }
}

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.data,
    required this.image,
    required this.tags,
  });

  final Recipe data;
  final String image;
  final List tags;

  @override
  Widget build(BuildContext context) {
    void toMenu(Recipe data) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(
            name: data.name,
            tags: data.tags,
            imageUrl: data.imageUrl,
            ingredients: data.ingredients,
            instructions: data.instructions,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => toMenu(data),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          title: Text(
            data.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tags
                .map((tag) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        tag,
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class MainAppBar extends StatefulWidget {
  const MainAppBar({super.key, required this.drawerKey});

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void drawerState() {
      if (widget.drawerKey.currentState!.isDrawerOpen) {
        widget.drawerKey.currentState!.closeDrawer();
      } else {
        widget.drawerKey.currentState!.openDrawer();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Receipe Book",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          onChanged: (value) => () {},
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: drawerState, icon: const Icon(Icons.menu)),
              prefixIconColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 2)),
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.black,
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {},
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.cancel, color: Colors.white))
                  : null),
        )
      ],
    );
  }
}
