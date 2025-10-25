import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final List<Map<String, String>> attractions = [
    {"img": "assets/eiffel.jpg", "name": "Eiffel Tower"},
    {"img": "assets/greatwall.jpg", "name": "Great Wall"},
    {"img": "assets/colosseum.jpg", "name": "Colosseum"},
    {"img": "assets/pyramids.jpg", "name": "Pyramids"},
    {"img": "assets/opera.jpg", "name": "Sydney Opera House"},
    {"img": "assets/statue.jpg", "name": "Statue of Liberty"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(10),
      children: attractions.map((place) {
        return Card(
          elevation: 4,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(place['img']!, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  place['name']!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
