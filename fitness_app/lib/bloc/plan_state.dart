part of 'plan_bloc.dart';

@immutable
abstract class PlanState {}

class PlanInitial extends PlanState {}


class PLanLoading extends PlanState {}

class PlanSuccess extends PlanState {
final Workout data;
  PlanSuccess(this.data);

}

class PlanFailure extends PlanState {}

 
