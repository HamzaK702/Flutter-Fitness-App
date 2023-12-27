import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'plan_event.dart';
part 'plan_state.dart';

 


class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanInitial()) {
    on<PlanRequested>(_onPlanRequested);
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
}