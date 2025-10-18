import 'package:flutter/material.dart';
import '../widgets/profile_info.dart';
import '../widgets/action_buttons.dart';
import '../widgets/description_box.dart';
import '../widgets/username_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Abdul Moiz"; // default name

  void updateUsername(String newName) {
    setState(() {
      username = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation == Orientation.portrait
        ? "Portrait"
        : "Landscape";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileInfo(username: username),
              const SizedBox(height: 20),
              const ActionButtons(),
              const SizedBox(height: 20),
              const DescriptionBox(),
              const SizedBox(height: 20),
              UsernameField(onUsernameChange: updateUsername),
              const SizedBox(height: 40),
              Text(
                "Current Orientation: $orientation",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
