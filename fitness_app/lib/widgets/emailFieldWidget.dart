import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final ValueKey<String> key;
  final Function(String?) onSaved;
  final String initialValue;

  EmailField({
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
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address.';
        }
        return null;
      },
      onSaved: onSaved,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: 'Email Address',
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white70,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: false,
    );
  }
}
