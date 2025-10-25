import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/travel.jpg', fit: BoxFit.cover),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: const Text(
              "Welcome to Travel Guide App! Plan your next adventure with us.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              text: "Explore ",
              style: TextStyle(fontSize: 22, color: Colors.black),
              children: [
                TextSpan(
                  text: "the World ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                TextSpan(text: "with Us!"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Destination",
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                    Text("Searching for: ${_destinationController.text}")),
              );
            },
            child: const Text("Search Destination"),
          ),
          TextButton(
            onPressed: () {
              print("TextButton clicked!");
            },
            child: const Text("Learn More"),
          ),
        ],
      ),
    );
  }
}
