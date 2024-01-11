

// import 'package:fitness_app/bloc/home/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc() : super(DayInitial()) {
    on<DayRequested>(_onDayRequested);
  }

  Future<void> _onDayRequested(DayRequested event, Emitter<DayState> emit) async {
    emit(DayLoading());
    try {
      final dayData = await fetchDayData(event.id);
      emit(DaySuccess(day: dayData.day));
    } catch (e) {
      emit(DayFailure(e.toString()));
    }
  }
}


Future<Split> fetchDayData(String userId) async {
  final response = await http.post(
    Uri.parse('https://fitnessappbackendnodejs-production.up.railway.app/plan/getWorkout'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'userId': userId}),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return Split.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch day data');
  }
}






  
   



