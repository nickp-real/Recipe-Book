import 'package:flutter/material.dart';
import 'package:receipe_book/pages/add_or_edit/add_or_edit_recipe.dart';

import 'widgets/appbar.dart';
import 'widgets/drawer.dart';
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: MainAppBar(drawerKey: _scaffoldKey),
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
  }
}


// Download Page
// class RecipeList extends StatelessWidget {
//   const RecipeList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collectionGroup('recipes').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               Recipe data = Recipe.fromJson(
//                   snapshot.data!.docs[index].data() as Map<String, dynamic>);
//               final tags = data.tags;
//               final image = data.imageUrl;
//               return RecipeTile(data: data, image: image, tags: tags);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
