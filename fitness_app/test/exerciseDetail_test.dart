import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:fitness_app/widgets/ExerciseDetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseDetailWidget Tests', () {
    testWidgets('displays exercise name and sets/reps when provided', (WidgetTester tester) async {
      // Creating a mock ExerciseDetail
      final mockExerciseDetail = ExerciseDetail(
        exercise: 'Push Ups',
        sets: "3",
        reps: "15",
        time: null, 
        id: '1122',
      );

      // Building the widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ExerciseDetailWidget(exerciseDetail: mockExerciseDetail),
        ),
      ));

      // Checking if the exercise name and sets/reps are displayed
      expect(find.text('Push Ups'), findsOneWidget);
      expect(find.text('Sets: 3, Reps: 15'), findsOneWidget);
    });

    testWidgets('displays exercise name and time when sets/reps are not provided', (WidgetTester tester) async {
      // Creating a mock ExerciseDetail with time instead of sets/reps
      final mockExerciseDetail = ExerciseDetail(
        exercise: 'Running',
        sets: null,
        reps: null,
        time: '30 mins', 
        id: '22',
      );

      // Building the widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ExerciseDetailWidget(exerciseDetail: mockExerciseDetail),
        ),
      ));

      // Checking if the exercise name and time are displayed
      expect(find.text('Running'), findsOneWidget);
      expect(find.text('Time: 30 mins'), findsOneWidget);
    });
  });
}
