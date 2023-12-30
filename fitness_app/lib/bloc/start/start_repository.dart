import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class StartRepository {
Future<Workout> fetchStartWorkout(String day) async {
  final response = await http.get(
    Uri.parse('http://localhost:3001/plan/getExercises').replace(queryParameters: {
      'day': day,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return Workout.fromJson(responseData);
  } else {
    throw Exception('Failed to load start workout data');
  }
}
}