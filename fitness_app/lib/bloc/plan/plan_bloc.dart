import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
 
import 'package:fitness_app/bloc/home/home_event_state.dart';
import 'package:fitness_app/bloc/plan/plan_repository.dart';


import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'plan_event.dart';
part 'plan_state.dart';

 


class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final  PlanRepository planRepository ;

  PlanBloc(this.planRepository) : super(PlanInitial()) {
    on<PlanRequested>(_onPlanRequested);
    on<UpdatePlan>(_onUpdatePlan); 
  }  

  Future<void> _onPlanRequested(PlanRequested event, Emitter<PlanState> emit) async {
    
    emit(PlanLoading());
    try {
      print("hello");
      final splitData = await planRepository.fetchPlan(event.id);
      print(splitData);
      print("--------------------------------------------------");
      emit(PlanSuccess(split: splitData));
    } catch (e) {
      emit(PlanFailure(e.toString()));
    }
  }

  Future<void> _onUpdatePlan(UpdatePlan event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final split = await planRepository.updatePlan(event.userId, event.split);
      print(split);
      emit(PlanSuccess(split: split));
     
    } catch (e) {
      emit(PlanFailure(e.toString()));
    }
  }
}


