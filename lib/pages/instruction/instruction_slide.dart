import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InstruntionSlideScreen extends StatefulWidget {
  final List<dynamic> instructions;

  const InstruntionSlideScreen({Key? key, required this.instructions})
      : super(key: key);

  @override
  State<InstruntionSlideScreen> createState() => _InstruntionSlideScreenState();
}

class _InstruntionSlideScreenState extends State<InstruntionSlideScreen> {
  List<Decoration?> decorations = [];
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    decorations = List.generate(
        widget.instructions.length,
        (_) => BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('วิธีทำ'),
      ),
      body: widget.instructions.isNotEmpty
          ? PageView.builder(
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
                  padding: const EdgeInsets.all(16),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Center(
                    child: Text(
                      widget.instructions[index],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              })
          : const Center(child: Text("No instruction provided.")),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(Icons.arrow_left),
            ),
            Text(
              '${widget.instructions.isNotEmpty ? currentPage + 1 : widget.instructions.length} / ${widget.instructions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(Icons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
