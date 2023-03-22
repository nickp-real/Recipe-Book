import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/model/recipe.dart';
import 'package:receipe_book/pages/find_recipe/find_recipe.dart';

import 'package:receipe_book/pages/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:receipe_book/pages/login/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => RecipeModel())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
        '/find': (context) => const FindRecipePage()
      },
      initialRoute: '/',
    );
  }
}
