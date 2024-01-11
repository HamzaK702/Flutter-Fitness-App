//import 'package:fitness_app/bloc/home/home_event_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlanRepository {
 Future<String> fetchPlan(String userId) async {
  print('Fetching plan for user: $userId'); // Logging statement

  final response = await http.post(
    Uri.parse('http://localhost:3001/plan/getSplit'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'userId': userId}),
  );

  if (response.statusCode == 200) {
    print('Plan fetched successfully'); // Logging statement

    final responseData = json.decode(response.body);
    print(responseData['split']);
    
    print("this is responseData: $responseData");
    return responseData['split'];
  } else {
    print('Failed to fetch plan'); // Logging statement

    throw Exception('Failed to fetch plan');
  }
}


  Future<String> updatePlan(String userId, String split) async {
    print("update plan called");
    final response = await http.post(
      Uri.parse('http://localhost:3001/plan/selectPlan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'split': split}),
    );

    if (response.statusCode == 200) {
      return split; // or any other response processing
    } else {
      throw Exception('Failed to update plan');
    }
  }
}
