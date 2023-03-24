/// This file contains the main application entry point and widget for the Recipe Book Flutter application.
///
/// The application utilizes the Flutter framework and several plugins such as firebase_core, provider, and flutter/material.
///
/// The main method initializes the Flutter application and sets the preferred screen orientation. It also creates a [MultiProvider] widget
/// that provides instances of [RecipeStorage] and [DownloadedStorage] to the rest of the application.
///
/// The [MyApp] class is the root widget of the application and returns a [MaterialApp] widget that defines the application's routes and
/// theme data.
///
/// The application has four routes: /, /login, /find, and /downloaded. The default route is /. The routes are mapped to the
/// corresponding pages defined in the pages directory.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:receipe_book/pages/find_recipe/find_recipe.dart';

import 'package:receipe_book/pages/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:receipe_book/pages/login/login.dart';
import 'package:receipe_book/services/downloaded_storage.dart';
import 'package:receipe_book/services/recipe_storage.dart';
import 'firebase_options.dart';
import 'pages/downloaded/downloaded.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => RecipeStorage()),
    ChangeNotifierProvider(create: (context) => DownloadedStorage()),
  ], child: const MyApp()));
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
        '/find': (context) => const FindRecipePage(),
        '/downloaded': (context) => const DownloadedPage()
      },
      initialRoute: '/',
    );
  }
}
