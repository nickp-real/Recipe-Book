import 'package:flutter/material.dart';
import 'menu.dart';
import 'add_recipe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collectionGroup('recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              List<dynamic> tags = data['tags'];
              String image = data['imageUrl'];
              List<dynamic> ingredients = data['ingredients'];
              List<dynamic> instructions = data['instructions'];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPage(name: data['name'], tags: tags, imageUrl: image,ingredients: ingredients,instructions: instructions,),
                    ),
                  );
                },

                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    title: Text(data['name'],style: const TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.white
                    ),),
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
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddRecipePage,
        child: const Icon(Icons.add),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Receipe Book",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: () {
                    if (widget.drawerKey.currentState!.isDrawerOpen) {
                      widget.drawerKey.currentState!.closeDrawer();
                    } else {
                      widget.drawerKey.currentState!.openDrawer();
                    }
                  },
                  icon: Icon(Icons.menu)),
              prefixIconColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 2)),
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.black),
        )
      ],
    );
  }
}
