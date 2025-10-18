import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Hi! I'm Abdul Moiz, a Flutter developer passionate about building creative and functional mobile apps.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
