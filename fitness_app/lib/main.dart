 
 
import 'package:fitness_app/bloc/plan_bloc.dart';
import 'package:fitness_app/bloc/start_bloc.dart';
import 'package:fitness_app/bloc/yoga_bloc.dart';
import 'package:fitness_app/home_bloc.dart';
import 'package:fitness_app/login_bloc.dart';
import 'package:fitness_app/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<DayBloc>(
          create: (context) => DayBloc(),
        ),
        BlocProvider<StartBloc>(
          create: (context) => StartBloc(),
        ),
        BlocProvider<PlanBloc>(
          create: (context) => PlanBloc(),
        ),
         BlocProvider<YogaBloc>(
          create: (context) => YogaBloc(),
        ),
      ],
      child: MyApp(),
    ),  
  );
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
