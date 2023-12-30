
import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:fitness_app/bloc/yoga/yoga_bloc.dart';
import 'package:fitness_app/widgets/ExerciseDetailWidget.dart';
import 'package:fitness_app/widgets/customButtonWidget.dart';
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
    bool isLastExercise = _currentIndex == _allExercises.length - 1;

    String category = _currentIndex < widget.workout.warmUp.length
        ? 'Warmup'
        : _currentIndex < widget.workout.warmUp.length + widget.workout.exercises.length
            ? 'Exercises'
            : 'Cooldown';

    return Container(
      
      decoration: BoxDecoration(
        
        color: Colors.grey[900],
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
          ExerciseDetailWidget(exerciseDetail: currentExercise),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: _currentIndex > 0 ? () => _navigateExercise(-1) : null,
            ),
            Spacer(),
            if (isLastExercise)
            CustomElevatedButton(
                    buttonText: 'FINISH WORKOUT',
                    onPressed: () {
                    
                    Navigator.of(context).pop();
                  },
                ),
              Spacer(),
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




class YogaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.black,  // Optional: Set AppBar color to black
      ),
      backgroundColor: Colors.black,  // Set the background color of the page
      body: BlocBuilder<YogaBloc, YogaState>(
        builder: (context, state) {
          if (state is YogaInitial) {
            return Center(
              child: Text('Select a day to start', style: TextStyle(color: Colors.white)),
            );
          } else if (state is YogaLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is YogaLoadedState) {
            return _buildStartWorkoutSection(context, state);
          } else if (state is YogaErrorState) {
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
Widget _buildStartWorkoutSection(BuildContext context, YogaLoadedState state) {
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
            child: 
               CustomElevatedButton(
                    buttonText: 'START YOGA',
                    onPressed: () => _showExerciseBottomSheet(context, state.data),

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