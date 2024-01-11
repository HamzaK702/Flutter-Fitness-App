 
import 'package:fitness_app/bloc/history/historyModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryRepository {
 Future<WorkoutHistory> fetchHistory(String userId) async {
    print("fetch history called");
     final response = await http.get(Uri.parse('https://fitnessappbackendnodejs-production.up.railway.app/plan/getHistory?userId=$userId'));

    if (response.statusCode == 200) {
    return WorkoutHistory.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load workout history');
  }
}


 Future<void> updateHistory(String userId, String workoutName) async {
  print("update history called");
  var url = Uri.parse('https://fitnessappbackendnodejs-production.up.railway.app/plan/historyWorkout'); // Replace with your server's IP and port
  try {
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'workoutName': workoutName,
      }),
    );

    if (response.statusCode == 200) {
      // Handle the response properly
      print('Workout history updated successfully');
    } else {
      // Error handling
      print('Failed to update workout history. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    print('Error occurred while updating workout history: $e');
  }
}
}
