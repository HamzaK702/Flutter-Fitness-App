import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:flutter/material.dart';

class ExerciseDetailWidget extends StatelessWidget {
  final ExerciseDetail exerciseDetail;

  ExerciseDetailWidget({required this.exerciseDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(exerciseDetail.exercise, style: TextStyle(fontSize: 18, color: Colors.white)),
        SizedBox(height: 10),
        Text(exerciseDetail.sets != null ? 'Sets: ${exerciseDetail.sets}, Reps: ${exerciseDetail.reps}' : 'Time: ${exerciseDetail.time}', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
