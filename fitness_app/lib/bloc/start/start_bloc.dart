import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/bloc/models/workoutModel.dart';
import 'package:fitness_app/bloc/start/start_repository.dart';
import 'package:meta/meta.dart';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  final  StartRepository startRepository ;

  StartBloc(this.startRepository) : super(StartInitial()) {
    on<WorkoutRequested>(_onWorkoutRequested);
  }  

  Future<void> _onWorkoutRequested(WorkoutRequested event, Emitter<StartState> emit) async {
    emit(StartLoading());
    try {
      final data = await startRepository.fetchStartWorkout(event.Day);
      emit(StartLoadedState(data: data));
    } catch (e) {
      emit(StartErrorState(e.toString()));
    }
  }
}





      
   
   


 
