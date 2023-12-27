
import 'package:fitness_app/bloc/start_bloc.dart';
import 'package:fitness_app/bloc/workoutModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class ExerciseBottomSheet extends StatefulWidget {
  final Workout workout;

  ExerciseBottomSheet({required this.workout});

  @override
  _ExerciseBottomSheetState createState() => _ExerciseBottomSheetState();
}

class _ExerciseBottomSheetState extends State<ExerciseBottomSheet> {
  int _currentIndex = 0;
  List<ExerciseDetail> _allExercises = [];

  @override
  void initState() {
    super.initState();
    _allExercises = widget.workout.warmUp + widget.workout.exercises + widget.workout.coolDown;
  }

  @override
  Widget build(BuildContext context) {
    ExerciseDetail currentExercise = _allExercises[_currentIndex];
    String category = _currentIndex < widget.workout.warmUp.length
        ? 'Warmup'
        : _currentIndex < widget.workout.warmUp.length + widget.workout.exercises.length
            ? 'Exercises'
            : 'Cooldown';

    return Container(
      
      decoration: BoxDecoration(
        
        color: Colors.grey[850],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(category, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 20),
          Text(currentExercise.exercise, style: TextStyle(fontSize: 18, color: Colors.white)),
          SizedBox(height: 10),
          Text(currentExercise.sets != null ? 'Sets: ${currentExercise.sets}, Reps: ${currentExercise.reps}' : 'Time: ${currentExercise.time}', style: TextStyle(color: Colors.white)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: _currentIndex > 0 ? () => _navigateExercise(-1) : null,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: _currentIndex < _allExercises.length - 1 ? () => _navigateExercise(1) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateExercise(int step) {
    setState(() {
      _currentIndex += step;
    });
  }
}



   // Import your ExerciseBottomSheet widget

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black,  // Optional: Set AppBar color to black
      ),
      backgroundColor: Colors.black,  // Set the background color of the page
      body: BlocBuilder<StartBloc, StartState>(
        builder: (context, state) {
          if (state is StartInitial) {
            return Center(
              child: Text('Select a day to start', style: TextStyle(color: Colors.white)),
            );
          } else if (state is StartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StartLoadedState) {
            return _buildStartWorkoutSection(context, state);
          } else if (state is StartErrorState) {
            return Center(
              child: Text('Error: ${state.message}', style: TextStyle(color: Colors.white)),
            );
          } else {
            return Center(child: Text('Unknown state', style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
Widget _buildStartWorkoutSection(BuildContext context, StartLoadedState state) {
  return SingleChildScrollView( // Wrap with SingleChildScrollView
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/${state.data.day}.png',
              
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "${state.data.day} Day",
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                state.data.details,
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: Colors.white),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topCenter,
            child: ElevatedButton(
              child: Text(
                'START WORKOUT',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              onPressed: () => _showExerciseBottomSheet(context, state.data),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF2FF00),
                onPrimary: Colors.white,
                minimumSize: Size(200, 50),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


void _showExerciseBottomSheet(BuildContext context, Workout workout) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Make modal background transparent
    builder: (context) => ExerciseBottomSheet(workout: workout),
  );
}

}