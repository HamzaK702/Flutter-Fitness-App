import 'package:fitness_app/bloc/start/start_bloc.dart';
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
     final response = await http.post(
        Uri.parse('http://localhost:3001/plan/getWorkout'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
        'userId': event.id
        }),
    );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final dayData = Split.fromJson(responseData);
        print("This is the day: ${dayData.day}");
        emit(DaySuccess(day: dayData.day));
        WorkoutRequested(Day: dayData.day);
      } else {
        emit(DayFailure('Day retrieval failed'));
      }
    } catch (e) {
      emit(DayFailure(e.toString()));
    }
  }
}



  
   



