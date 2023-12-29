part of 'start_bloc.dart';

@immutable
abstract class StartEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class WorkoutRequested extends StartEvent {
  final String Day;
  

  WorkoutRequested({required this.Day});

  @override
  List<Object> get props => [Day];
}