part of 'yoga_bloc.dart';

@immutable
abstract class YogaState extends Equatable {
  const YogaState();

  @override
  List<Object?> get props => [];
}

class YogaInitial extends YogaState {}

class YogaLoading extends YogaState {}

class YogaLoadedState extends YogaState {
  final Workout data;

  YogaLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class YogaErrorState extends YogaState {
  final String message;

  YogaErrorState(this.message);

  @override
  List<Object?> get props => [message];
}