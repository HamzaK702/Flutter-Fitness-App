part of 'start_bloc.dart';



@immutable
abstract class StartState {}

class StartInitial extends StartState {}

class StartLoading extends StartState {}



class StartLoadedState extends StartState {
    final Workout data;
    StartLoadedState({required this.data});
}

class StartErrorState extends StartState {
    final String message;
    StartErrorState(this.message);
}