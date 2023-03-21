import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar error({required String message}) {
    return SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(Icons.cancel),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Oh snap!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  static SnackBar success({required String message}) {
    return SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(Icons.check_circle_rounded),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Well done!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
