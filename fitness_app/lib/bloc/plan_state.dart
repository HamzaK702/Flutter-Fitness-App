part of 'plan_bloc.dart';

@immutable
abstract class PlanState {}

class PlanInitial extends PlanState {}


class PlanLoading extends PlanState {}

class PlanSuccess extends PlanState {
final String split;
  
  PlanSuccess({required this.split});

  @override
  List<Object> get props => [split];

}


class PlanFailure extends PlanState {
   final String message;
    PlanFailure(this.message);
}

 
 
class Split {
  final String split;
  // Add other fields as necessary

  Split({required this.split});

  factory Split.fromJson(Map<String, dynamic> json) {
    return Split(
      split: json['split']
      // Parse other fields
    );
  }
}


 