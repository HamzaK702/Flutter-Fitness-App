import 'package:bloc/bloc.dart';
import 'package:fitness_app/bloc/workoutModel.dart';
import 'package:meta/meta.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanInitial()) {
    on<PlanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
