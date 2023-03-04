import 'package:flutter/material.dart';
import 'menu.dart';
void main() {
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

  void _navigateToMenuPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuPage()),
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
      body: ListView(
        children: [
          GestureDetector(
            onTap: _navigateToMenuPage,
            child: Container(
              color: Color(0xFFD9D9D9),
              child: ListTile(
                leading: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                title: Text("Tomyum Kung"),
                subtitle: Text("Thai Cusine"),
              ),
            ),
          )
        ],
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
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
