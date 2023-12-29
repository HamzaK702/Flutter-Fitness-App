part of 'plan_bloc.dart';

@immutable
abstract class PlanEvent extends Equatable {
   @override
  List<Object> get props => [];
}


class PlanRequested extends PlanEvent {
 final String id;
  

  PlanRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdatePlan extends PlanEvent {
  final String userId;
  final String split;

  UpdatePlan({required this.userId,required this.split});

  @override
  List<Object> get props => [userId, split];
}