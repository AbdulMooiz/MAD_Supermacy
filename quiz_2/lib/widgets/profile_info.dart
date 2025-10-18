import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String username;

  const ProfileInfo({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 90,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 18),
            children: [
              TextSpan(
                text: "$username\n",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const TextSpan(
                text: "17abdulmoiz07@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
