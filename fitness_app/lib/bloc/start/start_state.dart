part of 'start_bloc.dart';

@immutable
abstract class StartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartInitial extends StartState {}

class StartLoading extends StartState {}

class StartLoadedState extends StartState {
  final Workout data;

  StartLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class StartErrorState extends StartState {
  final String message;

  StartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
