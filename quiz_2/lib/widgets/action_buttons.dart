import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Followed!')));
          },
          child: const Text("Follow"),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Message Sent!')));
          },
          child: const Text("Message"),
        ),
      ],
    );
  }
}
