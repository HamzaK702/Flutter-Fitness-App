import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final ValueKey<String> key;
  final Function(String?) onSaved;
  final String initialValue;

  PasswordField({
    required this.key,
    required this.onSaved,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      validator: (value) {
        if (value!.isEmpty || value.length < 7) {
          return 'Password must be at least 7 characters long.';
        }
        return null;
      },
      onSaved: onSaved,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white70,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
