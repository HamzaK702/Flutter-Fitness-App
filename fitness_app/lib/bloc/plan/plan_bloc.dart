import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/bloc/home/home_event_state.dart';


import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'plan_event.dart';
part 'plan_state.dart';

 


class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanInitial()) {
    on<PlanRequested>(_onPlanRequested);
     on<UpdatePlan>(_onUpdatePlan); 
    }  

Future<void> _onPlanRequested(PlanRequested event, Emitter<PlanState> emit) async {
    print("plan api was called: event: ${event.id}");
    emit(PlanLoading());
     try {
     final response = await http.post(
        Uri.parse('http://localhost:3001/plan/getSplit'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
        'userId': event.id
        }),
    );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body); 
         
        final splitData = Split.fromJson(responseData);
        print("This is the split: ${splitData.split }");
        emit(PlanSuccess(split: splitData.split));
      } else {
        emit(PlanFailure('Split retrieval failed'));
      }
    } catch (e) {
      emit(PlanFailure(e.toString()));
    }
    
  }
  Future<void> _onUpdatePlan(UpdatePlan event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3001/plan/selectPlan'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': event.userId,
          'split': event.split,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        emit(PlanSuccess(split: event.split));
        DayRequested(id: event.userId);
        print("plan changed calling new day");
        
      } else {
        emit(PlanFailure('Failed to update plan'));
      }
    } catch (e) {
      emit(PlanFailure(e.toString()));
    }
  }
}
