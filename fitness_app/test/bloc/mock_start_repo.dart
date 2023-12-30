// Mock Workout Data for Monday
import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:fitness_app/bloc/start/start_repository.dart';

Workout getMockMondayWorkout() {
  return Workout(
    id: 'mockId123',
    day: 'Monday',
    details: 'Mock workout details for Monday',
    warmUp: [
      ExerciseDetail(
        id: 'warmup1',
        exercise: 'Jumping Jacks',
        sets: '3',
        reps: '15',
        time: '2 minutes',
      ),
      // Add more warmup exercises as needed
    ],
    exercises: [
      ExerciseDetail(
        id: 'exercise1',
        exercise: 'Push-ups',
        sets: '4',
        reps: '12',
        time: 'N/A',
      ),
      ExerciseDetail(
        id: 'exercise2',
        exercise: 'Squats',
        sets: '4',
        reps: '15',
        time: 'N/A',
      ),
      // Add more main exercises as needed
    ],
    coolDown: [
      ExerciseDetail(
        id: 'cooldown1',
        exercise: 'Stretching',
        sets: 'N/A',
        reps: 'N/A',
        time: '5 minutes',
      ),
      // Add more cooldown exercises as needed
    ],
  );
}

// Mock Yoga Repository implementation
class MockStartRepository  implements StartRepository{
  Future<Workout> fetchStartWorkout(String day) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    if (day == 'Monday') {
      return getMockMondayWorkout();
    }
    // Add conditions for other days or a default response

    throw Exception('Failed to load workout data');
  }
}
