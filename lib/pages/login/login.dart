import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:receipe_book/auth.dart';
import 'package:receipe_book/pages/home/home.dart';
import 'package:receipe_book/validator.dart';
import 'package:receipe_book/widgets/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> handleOnLoginClick() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await Auth().signin(
          email: _emailController.text, password: _passwordController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.success(
          message:
              "Welcome back ${_emailController.text.substring(0, _emailController.text.indexOf('@'))}"));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackbar.error(message: e.toString()));
    }
  }

  Future<void> handleOnRegisterClick() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await Auth().createUser(
          email: _emailController.text, password: _passwordController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.success(
          message:
              "Welcome ${_emailController.text.substring(0, _emailController.text.indexOf('@'))}"));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackbar.error(message: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void handleOnSignupTap() {
      setState(() {
        _isLogin = !_isLogin;
      });
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.brown,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.book_rounded),
              Text(
                "Recipe Book",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  _EntryField(
                      controller: _emailController,
                      label: "Email",
                      validator: Validator.email),
                  const SizedBox(height: 10),
                  _PasswordEntryField(
                      controller: _passwordController,
                      label: "Password",
                      validator: Validator.password),
                  if (!_isLogin)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        _PasswordEntryField(
                            controller: _confirmController,
                            label: "Confirm Password",
                            validator: _isLogin
                                ? (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a password.";
                                    }
                                    if (_confirmController.text !=
                                        _passwordController.text) {
                                      return "Confirm password doesn't match the password above.";
                                    }
                                    return null;
                                  }
                                : null),
                      ],
                    ),
                ])),
          ),
          _isLogin
              ? ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("Login"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: handleOnLoginClick,
                )
              : ElevatedButton.icon(
                  icon: const Icon(Icons.edit_note),
                  label: const Text("Register"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: handleOnRegisterClick,
                ),
          const SizedBox(height: 5),
          Text.rich(
              style: const TextStyle(fontSize: 12),
              TextSpan(
                  text: _isLogin
                      ? " Don't have an account?, "
                      : "Already have an account?, ",
                  children: [
                    TextSpan(
                        text: _isLogin ? "Sign up" : "Login",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = handleOnSignupTap)
                  ]))
        ]),
      ),
    );
  }
}

class _EntryField extends StatelessWidget {
  const _EntryField(
      {required this.controller, required this.label, required this.validator});

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          floatingLabelStyle:
              const TextStyle(color: Colors.white, fontSize: 18),
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: Colors.red.shade300, width: 2)),
          errorStyle: TextStyle(color: Colors.red.shade300),
          filled: true,
          fillColor: Colors.black),
    );
  }
}

class _PasswordEntryField extends StatelessWidget {
  const _PasswordEntryField(
      {required this.controller, required this.label, required this.validator});

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      validator: validator,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          floatingLabelStyle:
              const TextStyle(color: Colors.white, fontSize: 18),
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: Colors.red.shade300, width: 2)),
          errorStyle: TextStyle(color: Colors.red.shade300),
          filled: true,
          fillColor: Colors.black),
    );
  }
}
