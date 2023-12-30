part of 'plan_bloc.dart';

@immutable
abstract class PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanSuccess extends PlanState {
  final String split;

  PlanSuccess({required this.split});

  @override
  List<Object?> get props => [split];
}

class PlanFailure extends PlanState {
  final String message;

  PlanFailure(this.message);

  @override
  List<Object?> get props => [message];
}
