// main.dart
import 'package:flutter/material.dart';
// import 'Auth.dart';
// import 'Register.dart';
import 'onboarding.dart'; // Import the onboarding screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Club',
      home: OnboardingScreen(),
    );
  }
}
