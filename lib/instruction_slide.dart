import 'package:flutter/material.dart';

class InstruntionSlideScreen extends StatefulWidget {
  final List<dynamic> instructions;

  const InstruntionSlideScreen({Key? key, required this.instructions})
      : super(key: key);

  @override
  _InstruntionSlideScreenState createState() => _InstruntionSlideScreenState();
}

class _InstruntionSlideScreenState extends State<InstruntionSlideScreen> {
  List<Decoration?> decorations = [];
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    decorations = List.generate(widget.instructions.length, (_) => BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('วิธีทำ'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.instructions.length,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Center(
              child: Text(
                widget.instructions[index],
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_left),
            ),
            Text(
              '${currentPage + 1} / ${widget.instructions.length}',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}