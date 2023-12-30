// import 'package:fitness_app/bloc/plan/plan_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// Future<Split> fetchDayData(String userId) async {
//   final response = await http.post(
//     Uri.parse('http://localhost:3001/plan/getWorkout'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'userId': userId}),
//   );

//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     return Split.fromJson(responseData);
//   } else {
//     throw Exception('Failed to fetch day data');
//   }
// }