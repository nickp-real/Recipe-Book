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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    }

    return Drawer(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Auth().currentUser == null
              ? ListTile(
                  leading: const Icon(Icons.login_rounded),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  title: const Text("Login"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: handleOnLoginClick,
                )
              : ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  title: const Text("Logout"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: handleOnLogoutClick,
                )
        ]),
      ),
    );
  }
}
