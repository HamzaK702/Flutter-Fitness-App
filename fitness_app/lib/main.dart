 
 
import 'package:fitness_app/bloc/history/history_bloc.dart';
import 'package:fitness_app/bloc/history/history_repository.dart';
import 'package:fitness_app/bloc/home/home_bloc.dart';
import 'package:fitness_app/bloc/login/login_bloc.dart';
import 'package:fitness_app/bloc/plan/plan_bloc.dart';
import 'package:fitness_app/bloc/plan/plan_repository.dart';
import 'package:fitness_app/bloc/start/start_bloc.dart';
import 'package:fitness_app/bloc/start/start_repository.dart';
import 'package:fitness_app/bloc/yoga/yoga_bloc.dart';
import 'package:fitness_app/bloc/yoga/yoga_repository.dart';
import 'package:fitness_app/scenes/auth/onboarding.dart';
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
          create: (context) => StartBloc(StartRepository()),
        ),
        BlocProvider<PlanBloc>(
          create: (context) => PlanBloc(PlanRepository()),
        ),
         BlocProvider<YogaBloc>(
          create: (context) => YogaBloc(YogaRepository()),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(HistoryRepository()),
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
