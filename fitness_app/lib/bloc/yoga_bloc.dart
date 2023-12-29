import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/bloc/workoutModel.dart';
 
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'yoga_event.dart';
part 'yoga_state.dart';

class YogaBloc extends Bloc<YogaEvent, YogaState> {
  YogaBloc() : super(YogaInitial()) {
    on<YogaRequested>(_onWorkoutRequested);
    }  

Future<void> _onWorkoutRequested(YogaRequested event, Emitter<YogaState> emit) async {
    print("api was called: event: ${event.Day}");
    emit(YogaLoading());
    try {
    final response = await http.get(
      Uri.parse('http://localhost:3001/plan/getExercises').replace(queryParameters: {
    'day': event.Day,
    }),
    );
    if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final data = Workout.fromJson(responseData);
         emit(YogaLoadedState(data: data));
      } else {
        emit(YogaErrorState('Day retrieval failed'));
      }
    } catch (e) {
      emit(YogaErrorState(e.toString()));
    }
  }
}





      
   
   


 
