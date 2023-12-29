import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ValueKey<String> key;
  final Function(String?) onSaved;
  final String hintText;
  final IconData icon;

  CustomTextField({
    required this.key,
    required this.onSaved,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      onSaved: onSaved,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: hintText,
        prefixIcon: Icon(
          icon,
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
