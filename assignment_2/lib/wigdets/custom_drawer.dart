import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onTap;
  CustomDrawer({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
              child: Text("Travel Guide Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => onTap(0),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Destinations"),
            onTap: () => onTap(1),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
