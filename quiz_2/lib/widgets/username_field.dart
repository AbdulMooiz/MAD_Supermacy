import 'package:flutter/material.dart';

class UsernameField extends StatefulWidget {
  final Function(String) onUsernameChange;

  const UsernameField({super.key, required this.onUsernameChange});

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  final TextEditingController _controller = TextEditingController();
  String message = '';

  void _validate() {
    setState(() {
      if (_controller.text.isEmpty) {
        message = "Username cannot be empty!";
      } else {
        message = "Username updated!";
        widget.onUsernameChange(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: "Enter Username",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.check),
              onPressed: _validate,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: TextStyle(
            color: message.contains("updated") ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
