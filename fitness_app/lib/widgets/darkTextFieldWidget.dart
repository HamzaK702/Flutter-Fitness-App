import 'package:flutter/material.dart';

class DarkTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  DarkTextField({
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
Widget build(BuildContext context) {
  return TextFormField(
    controller: controller,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[800],
     
    
     
    ),
    onChanged: onChanged,
  );
}
}