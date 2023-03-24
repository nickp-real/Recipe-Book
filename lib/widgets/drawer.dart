import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipe_book/auth.dart';
import 'package:receipe_book/pages/login/login.dart';
import 'package:receipe_book/widgets/custom_snackbar.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)!;
    void handleOnLoginClick() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

    Future<void> handleOnLogoutClick() async {
      try {
        await Auth().signout();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar.success(message: "Logout successful."));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar.error(message: e.toString()));
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    void handleOnFindRecipesClick() {
      if (currentRoute.settings.name == '/find') return;
      Navigator.of(context).pushReplacementNamed('/find');
    }

    void handleOnYourRecipesClick() {
      if (currentRoute.settings.name == '/') return;
      Navigator.of(context).pushReplacementNamed('/');
    }

    void handleOnDownloadedRecipesClick() {
      if (currentRoute.settings.name == '/downloaded') return;
      Navigator.of(context).pushReplacementNamed('/downloaded');
    }

    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(children: [
            if (Auth().currentUser != null)
              Column(
                children: [
                  _DrawerTile(
                      icon: Icons.person,
                      title:
                          "Hello ${Auth().currentUser!.email!.substring(0, Auth().currentUser!.email!.indexOf('@'))}",
                      onTap: null),
                  const Divider(color: Colors.grey, thickness: 1.5),
                ],
              ),
            _DrawerTile(
                icon: Icons.search_rounded,
                title: "Find Recipes",
                onTap: handleOnFindRecipesClick,
                isRoute: currentRoute.settings.name == '/find'),
            _DrawerTile(
                icon: Icons.book_rounded,
                title: "Your Recipes",
                onTap: handleOnYourRecipesClick,
                isRoute: currentRoute.settings.name == '/'),
            _DrawerTile(
                icon: Icons.file_download_outlined,
                title: "Downloaded Recipes",
                onTap: handleOnDownloadedRecipesClick,
                isRoute: currentRoute.settings.name == '/downloaded'),
            const Spacer(),
            const Divider(color: Colors.grey, thickness: 1.5),
            Auth().currentUser == null
                ? _DrawerTile(
                    icon: Icons.login_rounded,
                    title: "Login",
                    onTap: handleOnLoginClick)
                : _DrawerTile(
                    icon: Icons.logout_rounded,
                    title: "Logout",
                    onTap: handleOnLogoutClick)
          ]),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile(
      {required this.icon,
      required this.title,
      required this.onTap,
      this.isRoute = false});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isRoute;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      iconColor: Colors.white,
      textColor: Colors.white,
      tileColor: isRoute ? Colors.brown : null,
      title: Text(title),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}
