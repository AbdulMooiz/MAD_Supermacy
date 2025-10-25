import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {"name": "Paris", "desc": "The city of love and lights."},
    {"name": "Tokyo", "desc": "A mix of tradition and modern tech."},
    {"name": "New York", "desc": "The city that never sleeps."},
    {"name": "Dubai", "desc": "Futuristic city with desert views."},
    {"name": "Rome", "desc": "The capital of ancient history."},
    {"name": "Sydney", "desc": "Home to the famous Opera House."},
    {"name": "Istanbul", "desc": "Where Europe meets Asia."},
    {"name": "London", "desc": "Cultural and historical capital."},
    {"name": "Bali", "desc": "Tropical paradise of Indonesia."},
    {"name": "Cairo", "desc": "City of ancient pyramids."},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: Colors.teal),
            title: Text(destinations[index]['name']!),
            subtitle: Text(destinations[index]['desc']!),
          ),
        );
      },
    );
  }
}
