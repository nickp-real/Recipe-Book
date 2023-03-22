import 'package:flutter/material.dart';

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
          "Recipe Book",
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
