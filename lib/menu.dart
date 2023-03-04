import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class MenuPageInfo extends StatefulWidget {
  const MenuPageInfo({Key? key}) : super(key: key);

  @override
  _MenuPageInfoState createState() => _MenuPageInfoState();
}


class _MenuPageInfoState extends State<MenuPageInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Image goes here",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Thai Crusine",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ingredient",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.circle, color: Colors.grey[400], size: 12),
              const SizedBox(width: 10),
              const Text(
                "Ingredient 1",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.circle, color: Colors.grey[400], size: 12),
              const SizedBox(width: 10),
              const Text(
                "Ingredient 2",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.circle, color: Colors.grey[400], size: 12),
              const SizedBox(width: 10),
              const Text(
                "Ingredient 3",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.circle, color: Colors.grey[400], size: 12),
              const SizedBox(width: 10),
              const Text(
                "Ingredient 4",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.circle, color: Colors.grey[400], size: 12),
              const SizedBox(width: 10),
              const Text(
                "Ingredient 5",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Instruction",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          const Row(
            children: [
              SizedBox(width: 20),
              SizedBox(width: 10),
              Text(
                "1. One thing",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          const Row(
            children: [
              SizedBox(width: 20),
              SizedBox(width: 10),
              Text(
                "2. Damn bro",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tomyum Kung",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: const Center(
        child: MenuPageInfo(),
      ),
    );
  }
}