import 'package:flutter/material.dart';
import 'package:fitness_app/bloc/start_bloc.dart'; // Replace with your actual path
import 'package:fitness_app/bloc/workoutModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Replace with your actual path

class StartWorkoutScreen extends StatefulWidget {
  @override
  _StartWorkoutScreenState createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  int currentExerciseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<StartBloc, StartState>(
        builder: (context, state) {
          if (state is StartLoadedState) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        state.data.day,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: _buildExerciseList(context, 'Exercises', state.data.exercises.cast<ExerciseDetail>()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _showWorkoutModal(context, state.data as Workout),
                      child: Text('Start Workout'),
                      style: ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'No workout plan loaded',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  void _showWorkoutModal(BuildContext context, Workout workout) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildExerciseDetails(workout),
            _buildNavigationButtons(workout),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseDetails(Workout workout) {
    ExerciseDetail currentExercise = getCurrentExercise(workout);
    return ListTile(
      title: Text(
        currentExercise.exercise,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        currentExercise.sets != null && currentExercise.reps != null
            ? 'Sets: ${currentExercise.sets}, Reps: ${currentExercise.reps}'
            : 'Time: ${currentExercise.time}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  ExerciseDetail getCurrentExercise(Workout workout) {
    // Replace this logic with how your Workout model is structured
    if (currentExerciseIndex < workout.warmUp.length) {
      return workout.warmUp[currentExerciseIndex];
    } else if (currentExerciseIndex < workout.warmUp.length + workout.exercises.length) {
      return workout.exercises[currentExerciseIndex - workout.warmUp.length];
    } else {
      return workout.coolDown[currentExerciseIndex - workout.warmUp.length - workout.exercises.length];
    }
  }

  Widget _buildNavigationButtons(Workout workout) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_left, color: Colors.white),
          onPressed: () {
            if (currentExerciseIndex > 0) {
              setState(() {
                currentExerciseIndex--;
              });
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_right, color: Colors.white),
          onPressed: () {
            if (currentExerciseIndex < workout.totalExercises() - 1) {
              setState(() {
                currentExerciseIndex++;
              });
            }
          },
        ),
      ],
    );
  }

  List<Widget> _buildExerciseList(BuildContext context, String title, List<ExerciseDetail> exercises) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      ...exercises.map((exercise) => ListTile(
            title: Text(
              exercise.exercise,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              exercise.sets != null && exercise.reps != null
                ? 'Sets: ${exercise.sets}, Reps: ${exercise.reps}'
                : 'Time: ${exercise.time}',
              style: TextStyle(color: Colors.white),
            ),
          )).toList(),
    ];
  }
}

class Workout {
  // Define your Workout model here
  String day;
  List<ExerciseDetail> warmUp;
  List<ExerciseDetail> exercises;
  List<ExerciseDetail> coolDown;

  Workout({required this.day, required this.warmUp, required this.exercises, required this.coolDown});

  int totalExercises() {
    return warmUp.length + exercises.length + coolDown.length;
  }
}

class ExerciseDetail {
  // Define your ExerciseDetail model here
  String exercise;
  int sets;
  int reps;
  String time;

  ExerciseDetail({required this.exercise,required this.sets, required this.reps, required this.time});
}