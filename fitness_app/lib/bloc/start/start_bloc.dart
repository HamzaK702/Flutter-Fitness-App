import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc() : super(StartInitial()) {
    on<WorkoutRequested>(_onWorkoutRequested);
    }  

Future<void> _onWorkoutRequested(WorkoutRequested event, Emitter<StartState> emit) async {
    print("api was called: event: ${event.Day}");
    emit(StartLoading());
    try {
    final response = await http.get(
      Uri.parse('http://localhost:3001/plan/getExercises').replace(queryParameters: {
    'day': event.Day,
    }),
    );
    if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final data = Workout.fromJson(responseData);
         emit(StartLoadedState(data: data));
      } else {
        emit(StartErrorState('Day retrieval failed'));
      }
    } catch (e) {
      emit(StartErrorState(e.toString()));
    }
  }
}





      
   
   


 
