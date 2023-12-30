import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/bloc/history/history_bloc.dart';
import 'package:fitness_app/bloc/history/historyModel.dart'; // Ensure this is the correct path to your model

class WorkoutHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HistorySuccess) {
            return _buildWorkoutList(state.workoutHistory);
          } else if (state is HistoryFailure) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No data available'));
        },
      ),
    );
  }

 Widget _buildWorkoutList(WorkoutHistory history) {
  return Container(
    color: Colors.black, // Dark background color
    child: ListView.builder(
      itemCount: history.previousWorkouts.length,
      itemBuilder: (context, index) {
        // Access the workouts in reverse order
        final workout = history.previousWorkouts[history.previousWorkouts.length - 1 - index];
        
        return ListTile(
          title: Text(
            workout.name,
            style: TextStyle(color: Colors.white), // Workout name text color
          ),
          subtitle: Text(
            _formatDate(workout.date),
            style: TextStyle(color: Colors.grey[800]), // Workout date text color
          ),
        );
      },
    ),
  );
}

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day} ${_monthName(date.month)} ${date.year}';
    }
  }

  String _monthName(int month) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[month - 1];
  }
}
