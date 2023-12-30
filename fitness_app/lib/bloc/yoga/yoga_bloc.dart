import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:fitness_app/bloc/yoga/yoga_repository.dart';
 import 'package:meta/meta.dart';
part 'yoga_event.dart';
part 'yoga_state.dart';

 

class YogaBloc extends Bloc<YogaEvent, YogaState> {
final  YogaRepository yogaRepository ;
  YogaBloc(this.yogaRepository) : super(YogaInitial()) {
    on<YogaRequested>(_onWorkoutRequested);
  }  

  Future<void> _onWorkoutRequested(YogaRequested event, Emitter<YogaState> emit) async {
    emit(YogaLoading());
    try {
      final data = await yogaRepository.fetchWorkout(event.Day);
      emit(YogaLoadedState(data: data));
    } catch (e) {
      emit(YogaErrorState(e.toString()));
    }
  }
}



 

