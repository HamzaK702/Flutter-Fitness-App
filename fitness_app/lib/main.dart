// main.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/login_bloc.dart';
import 'package:flutter/material.dart';
 import 'Auth.dart';
// import 'Register.dart';
import 'onboarding.dart'; // Import the onboarding screen file
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        title: 'Fitness Club',
        home: AuthScreen(),
      ),
    );
  }
}
